#
# Cookbook Name:: capita_rpp
# Recipe:: iisfeatures
#
# Copyright 2012, AKQA
#
# All rights reserved - Do Not Redistribute
#

include_recipe "windows"

windows_feature "IIS-ManagementScriptingTools" do
  action :install
end

windows_feature "IIS-ManagementService" do
  action :install
end