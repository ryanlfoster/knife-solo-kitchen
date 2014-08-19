include_recipe "varnish::default"
include_recipe "simple_iptables"


template "#{node['varnish']['VARNISH_VCL_CONF']}" do
  source "default.vcl.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :wgc => node['wgc']
  )
end

service "varnish" do
  action [ :restart ]
end

case node['platform_family']
  when 'rhel'

    ["#{node['wgc']['origin_http_port_for_ssl']}", "#{node['varnish']['VARNISH_LISTEN_PORT']}", "#{node['varnish']['VARNISH_ADMIN_LISTEN_PORT']}" ].each do |port|

        simple_iptables_rule "system" do
          Chef::Log.debug("Adding accept iptable rule for port #{port}")
          rule "--proto tcp --dport #{port}"
          jump "ACCEPT"
        end
    end

end
