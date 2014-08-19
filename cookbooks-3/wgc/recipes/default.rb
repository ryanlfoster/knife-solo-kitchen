#
# Cookbook Name:: wgc
# Recipe:: default
#
# Copyright 2013, AKQA
#
# All rights reserved - Do Not Redistribute
#

include_recipe "wgc::hosts"
include_recipe "wgc::nginx"
include_recipe "wgc::varnish"
