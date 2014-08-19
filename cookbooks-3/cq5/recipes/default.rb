#
# Cookbook Name:: cq5
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

installation_dir = node["cq5"]["installation_dir"]
installation_type = node["cq5"]["installation_type"]
port = node["cq5"]["port"]

install_path = "#{installation_dir}/#{installation_type}"
min_heap = node["cq5"]["min_heap"]
max_heap = node["cq5"]["max_heap"]
perm_gen = node["cq5"]["perm_gen"]
cq5_version = node["cq5"]["version"]
cq5_jar_url  = node["cq5"][cq5_version]["jar_url"]
cq5_license_url = node["cq5"]["license_url"]
is_reinstall = node["cq5"]["is_reinstall"]
install_packages = node["cq5"]["install_packages"]
jar_name = "cq-#{installation_type}-#{port}.jar"
script_path = node["cq5"][cq5_version]["script_path"]
pid_file_path = node["cq5"][cq5_version]["pid_file_path"]
sling_run_modes = node["cq5"]["sling_run_modes"]


 directory "#{install_path}" do
      mode "0755"
      owner "root"
      group "root"
      action :create
      recursive true
end

if is_reinstall
	# delete the install directory if its a re-install
	file "#{install_path}/#{jar_name}" do
		action :delete
		notifies :stop, "service[CQ5-#{installation_type}]", :immediately
		only_if{is_reinstall}
	end	
	# delete the install directory if its a re-install
	directory "#{install_path}/crx-quickstart" do
		action :delete
		recursive true
		only_if{is_reinstall}
	end
end

remote_file "#{install_path}/#{jar_name}" do
  source "#{cq5_jar_url}" 
  mode "0755"
  action :create_if_missing
end

if cq5_license_url.nil?
    log "No CQ license file supplied"
else
    log "Loading license file from " + cq5_license_url
    remote_file "#{install_path}/license.properties" do
        source "#{cq5_license_url}"  
        mode "0755"
        action :create_if_missing
    end
end

is_new_install = !File.exist?("#{install_path}/crx-quickstart")
execute "unpack CQ jar" do
  command "java -jar #{jar_name} -unpack"
  creates "#{install_path}/crx-quickstart"
  cwd "#{install_path}"
  action :run
end

if install_packages != nil
  install_packages.each {|package_url|
    log "Installing package from #{package_url}"
    # Prefix with zz to ensure that our packages are installed after the main CQ content
    filename = "zz_" + package_url.split("/").last
    remote_file "#{install_path}/crx-quickstart/repository/install/#{filename}" do
      source "#{package_url}"  
      mode "0755"
      action :create_if_missing
    end
  }
end  

if is_new_install  
	template "#{install_path}/crx-quickstart/server/etc/server.xml" do
	  source "server.xml.erb"
	  mode "0755"
	end
end


cookbook_file "#{install_path}/crx-quickstart/server/etc/ssl_keystore" do
  source "ssl_keystore"
  mode "0755"
  owner "root"
  group "root"
  action :create_if_missing
end

execute "chmod " do
  command "chmod -R 777 ./crx-quickstart "
  cwd "#{install_path}"
  action :run
end

template "/etc/init.d/cq#{installation_type}" do
  source "cq_init_d_#{cq5_version}.erb"
  mode "0755"
  variables(
    :installation_path => "#{install_path}#{script_path}",
	:cq_pid_file_path => "#{install_path}#{pid_file_path}",
 	:min_heap => "#{min_heap}",
	:max_heap => "#{max_heap}",
	:perm_gen => "#{perm_gen}",
	:sling_run_modes => "#{sling_run_modes}"
 )
  action :create_if_missing
end

service "CQ5-#{installation_type}" do
  service_name "cq#{installation_type}"
  supports  :stop =>true, :start => true, :status => true
  action [:enable, :start]
end
if is_new_install
  message  = <<-EOS
  
    ****************************************************
    CQ is starting up for the first time. 
    Please allow a few minutes before trying to connect
    with your web browser
    ****************************************************
    
  EOS
  log(message) {level :warn}
end