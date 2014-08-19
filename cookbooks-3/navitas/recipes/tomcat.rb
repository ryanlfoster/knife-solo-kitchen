include_recipe "simple_iptables"
include_recipe "tomcat::default"

version = node['tomcat']['version'].to_s
tomcat_version = "tomcat#{node['tomcat']['version'].to_s}"
tomcat_base = node['tomcat']['base'].to_s
tomcat_user = node['tomcat']['user'].to_s

cookbook_file "#{tomcat_base}/conf/tomcat-users.xml" do
  source "tomcat-users.xml"
  mode "0775"
  owner tomcat_user
  group tomcat_user
  action :create
end

directory "/navitas/logs/tomcat/" do
  mode "0755"
  owner tomcat_user
  group tomcat_user
  recursive true
  action :create
end

service tomcat_version do
  action :restart
end

case node['platform_family']
  when 'rhel'

    http_port = node["tomcat"]["http_port"]
    ssl_port = node["tomcat"]["ssl_port"]

    [ http_port, ssl_port ].each do |port|

      simple_iptables_rule "system" do
        Chef::Log.debug("Adding accept iptable rule for port #{port}")
        rule "--proto tcp --dport #{port}"
        jump "ACCEPT"
      end
    end
end

