include_recipe "mysql::server"

# create database for toolbox

directory node['toolbox']['mysql_dir'].to_s do
  mode "0755"
  owner "root"
  group node['mysql']['root_group']
  recursive true
  action :create
end

schema_path = node['toolbox']['mysql_schema_path'].to_s
data_path = node['toolbox']['sql_file_path'].to_s

execute "mysql-install-schema" do
  command %Q["#{node['mysql']['mysql_bin']}" -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }"#{node['mysql']['server_root_password']}" < "#{schema_path}"]
  action :nothing
end

template schema_path do
  source "toolbox.sql.erb"
  owner "root"
  group node['mysql']['root_group']
  mode "0755"
  action :create_if_missing
  notifies :run, "execute[mysql-install-schema]", :immediately
end

remote_file "/tmp/#{node['toolbox']['sql_data']}" do
  source "#{node['toolbox']['sql_url']}"
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
  command "tar -jxf #{node['toolbox']['sql_data']}"
  action :run
  notifies :run, "execute[mysql-install-data]", :immediately
end

