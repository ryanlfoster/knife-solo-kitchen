
template "/etc/hosts" do
  source "hosts.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
	:wgc => node['wgc']
  )
end
