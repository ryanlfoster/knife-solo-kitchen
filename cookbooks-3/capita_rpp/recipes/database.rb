#
# Cookbook Name:: capita_rpp
# Recipe:: database
#
# Copyright 2012, AKQA
#
# All rights reserved - Do Not Redistribute
#

# just installs sql server express at the moment. See http://community.opscode.com/cookbooks/sql_server for more info

node.default['sql_server']['accept_eula'] = true

include_recipe "sql_server::server"