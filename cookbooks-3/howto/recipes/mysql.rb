# create database for toolbox

directory node['howto']['mysql_dir'].to_s do
  mode "0755"
  owner "root"
  group node['mysql']['root_group']
  recursive true
  action :create
end

data_path = node['howto']['sql_file_path'].to_s

remote_file "/tmp/#{node['howto']['sql_data']}" do
  source "#{node['howto']['sql_url']}"
  owner "root"
  group node['mysql']['root_group']
  mode "0755"
  action :create_if_missing
end

execute "mysql-install-data" do
  command %Q["#{node['mysql']['mysql_bin']}" -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }"#{node['mysql']['server_root_password']}" < "#{data_path}"]
  action :nothing
end

execute "tar" do 
  cwd "/tmp"
  command "tar -jxf #{node['howto']['sql_data']}"
  action :run
  notifies :run, "execute[mysql-install-data]", :immediately
end
