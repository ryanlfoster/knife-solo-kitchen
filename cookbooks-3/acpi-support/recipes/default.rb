#
# Cookbook Name:: acpi-support
# Recipe:: default
#

case node['platform_family']
  when 'rhel'

    package "acpid" do
      action :install
    end


    service "acpid" do
      action [:enable, :start]
    end

  when 'debian'
    package "acpi-support" do
      action :install
    end


end


