include_recipe "apache2"

arch = node['kernel']['machine'] =~ /x86_64/ ? "amd64" : "i386"

# Add the rewrite, proxy & proxy_http modules to apache

["rewrite","proxy","proxy_http","expires","ssl"].each do |mod_name|
	apache_module mod_name 
end

# Add the dispatcher site
web_app "dispatcher" do
  server_aliases [node['fqdn'], "localhost"]
  application_name "dispatcher"
  docroot "/data/dispatcher"
  server_name node['hostname']
  template "dispatcher.conf.erb"
  landing_page node['dispatcher']['landing_page']
end

# Set up the docroot directory for the dispatcher virtual host
directory "/data/dispatcher" do

	owner node['apache']['user']
	group node['apache']['group']

	mode "0755"
	action :create
end


#Set up the dispatcher config
template "#{node['apache']['dir']}/dispatcher.any" do
  source "dispatcher.any.erb"
  mode "0644"
  variables(
    :renderer_port => "#{node['dispatcher']['renderer']['port']}",
    :renderer_hostname => "#{node['dispatcher']['renderer']['hostname']}",
    :serveStaleOnError => "1",
    :statfileslevel => "1",
    :docroot => "/data/dispatcher"
  )
  action :create_if_missing
end 


# Copy dispatcher module into place
cookbook_file "#{node['apache']['libexecdir']}/mod_dispatcher.so" do
	owner "root"
	group "root"
	mode "0644"

	case arch
		when "amd64"
			source "dispatcher-apache2.2-4.1.0-x86-64.so"
		when "i386"
			source "dispatcher-apache2.2-4.1.0-i686.so"			
	end
end

# Enable the dispatcher module
template "#{node['apache']['dir']}/mods-available/dispatcher.load" do
	source "dispatcher.load.erb"
	mode "0644"
	variables(
    	:dispatcher_log_level => "1",
    	:config_file_path => "dispatcher.any"
 	)
	action :create_if_missing
end

apache_module "dispatcher" do
	enable "true"
end 

# Remove the default web site
apache_site "default" do
	enable false
end