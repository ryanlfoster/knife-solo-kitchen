#
# Cookbook Name:: capita_rpp
# Recipe:: website
#
# Copyright 2012, AKQA
#
# All rights reserved - Do Not Redistribute
#

# install IIS 7
node.default['iis']['accept_eula'] = true
include_recipe "iis"

# install additional iis features specific to capita
include_recipe "capita_rpp::iisfeatures"

# install deployment account
include_recipe "capita_rpp::deploymentaccount"