include_attribute "wordpress"

default['howto']['mysql_dir'] = '/etc/howto/mysql'
default['howto']['sql_data'] = "wpsql.tar.bz2"
default['howto']['sql_url'] = "http://automation.akqa.net/data/wp/#{node['howto']['sql_data']}"
default['howto']['sql_file'] = "wp.sql"
default['howto']['sql_file_path'] = "/tmp/#{node['howto']['sql_file']}"
default['howto']['wp_theme_path'] = "/etc/mysql/wp_set_theme.sql"
default['howto']['wp_sql_admin'] = "/etc/mysql/wp_add_admin.sql"
default['howto']['wp']['sql_theme_path']=""
default['howto']['wp']['current_theme']="AKQA How2"
default['howto']['wp']['template']="how2"
default['howto']['wp']['stylesheet']="how2"
default['howto']['wp']['database']= "#{node['wordpress']['db']['database']}"


default['howto']['wp']['dev']['username']="dadmin"
default['howto']['wp']['dev']['password']="pass"


