#
# Cookbook Name:: java-oab
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

 remote_file "/tmp/#{node['oab']['sh']}" do
   source "#{node['oab']['url']}"
   mode 0755
   action :create_if_missing
 end

 execute "bash" do
   cwd "/tmp"
   command "./#{node['oab']['sh']}"
   action :run
 end

 package "sun-java6-jdk" do
   action :install
 end
