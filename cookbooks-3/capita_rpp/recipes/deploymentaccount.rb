#
# Cookbook Name:: capita_rpp
# Recipe:: deploymentaccount
#
# Copyright 2012, AKQA
#
# All rights reserved - Do Not Redistribute
#
# Hashed password: Tuesday24

user "capita_deploy" do
  comment "Capita RPP Deployment account"
  password "$6$YGQv.BCd3sbU$zqIK2pYLcEBIAmvi7GfuuzT77U1z/7jSxlaaOpYBfJx9r/CKZxaADcBsbHSDjHo0dPZVygdKMca/jrKwS/rEn1"
end

group "Administrators" do
	action :modify
	members "capita_deploy"
	append true
end