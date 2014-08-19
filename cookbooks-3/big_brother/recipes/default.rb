#
# Cookbook Name:: big_brother
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "windows"

remote_file "C:/temp/bb-install.exe" do
  source "http://automation.akqa.net/software/bigbrother/bb-install.exe"
  action :create_if_missing
end

windows_package "Big Brother" do
  source "c:/temp/bb-install.exe"
  installer_type :installshield
  options "/s /v/qn"
  action :install
end

windows_batch "Big Brother Service" do
  cwd "c:/Program Files (x86)/Quest Software/Big Brother/BBNT/5.00/bin/"
  code <<-EOH
    bbnt.exe -y -install xymon
  EOH
end

service "BigBrotherClient" do
  action :start
end
