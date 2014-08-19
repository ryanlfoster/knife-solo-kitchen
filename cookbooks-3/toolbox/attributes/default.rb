default['toolbox']['mysql_dir'] = '/etc/toolbox/mysql'
default['toolbox']['mysql_schema_path'] = "#{node['toolbox']['mysql_dir']}/toolbox.sql"
default['toolbox']['sql_data'] = "toolboxsql.tar.bz2"
default['toolbox']['sql_url'] = "http://automation.akqa.net/data/toolbox/#{node['toolbox']['sql_data']}"
default['toolbox']['sql_file'] = "toolbox.sql"
default['toolbox']['sql_file_path'] = "/tmp/#{node['toolbox']['sql_file']}"
