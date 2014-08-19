include_recipe 'nginx::default'
include_recipe "simple_iptables"

template "#{node['nginx']['dir']}/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :wgc => node['wgc'],
	:nginx => node['nginx']
  )
end

template "#{node['wgc']['cert_path']}/privatekey.pem" do
  source "privatekey.pem.erb"
  owner "root"
  group "root"
  mode 0644
end

template "#{node['wgc']['cert_path']}/cacert.pem" do
  source "cacert.pem.erb"
  owner "root"
  group "root"
  mode 0644
end

case node['platform_family']
  when 'rhel'

    ["#{node['wgc']['client_ssl_port']}"].each do |port|

        simple_iptables_rule "system" do
          Chef::Log.debug("Adding accept iptable rule for port #{port}")
          rule "--proto tcp --dport #{port}"
          jump "ACCEPT"
        end
    end

end

service 'nginx' do
  action :restart
end