include_recipe "varnish::default"
include_recipe "simple_iptables"


template "#{node['varnish']['config_dir']}/default.vcl" do
  source "default.vcl.erb"
  owner "root"
  group "root"
  mode 0644

end

# Reload the new config
service "varnish" do
  action :reload
end


case node['platform_family']
  when 'rhel'

    ["#{node['varnish']['VARNISH_LISTEN_PORT']}", "#{node['varnish']['VARNISH_ADMIN_LISTEN_PORT']}" ].each do |port|

        simple_iptables_rule "system" do
          Chef::Log.debug("Adding accept iptable rule for port #{port}")
          rule "--proto tcp --dport #{port}"
          jump "ACCEPT"
        end
    end

end
