# create database for toolbox
include_recipe "php::module_ldap"

remote_directory "/var/www/wordpress/wp-content/plugins/active-directory-integration" do
  source "active-directory-integration"
  recursive true
  files_mode 0755
  files_owner "www-data"
  owner "www-data"
  action :create
end