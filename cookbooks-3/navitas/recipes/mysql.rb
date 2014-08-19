include_recipe "simple_iptables"
include_recipe "mysql::server"


# create database for navitas grails apps

directory node['navitas']['mysql_dir'].to_s do
  mode "0755"
  owner "root"
  group node['mysql']['root_group']
  recursive true
  action :create
end

schema_path = node['navitas']['mysql_schema_path'].to_s


execute "mysql-install-schema" do
  command %Q["#{node['mysql']['mysql_bin']}" -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }"#{node['mysql']['server_root_password']}" < "#{schema_path}"]
  action :nothing
end

template schema_path do
  source "navitas_schema_create.sql.erb"
  owner "root"
  group node['mysql']['root_group']
  mode "0755"
  action :create_if_missing
  notifies :run, "execute[mysql-install-schema]", :immediately
end

case node['platform_family']
  when 'rhel'

    %W(#{node['mysql']['port']}).each do |port|

      simple_iptables_rule "system" do
        Chef::Log.debug("Adding accept iptable rule for port #{port}")
        rule "--proto tcp --dport #{port}"
        jump "ACCEPT"
      end
    end
end