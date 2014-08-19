
wp_sql_admin_path = node['howto']['wp_sql_admin']

  begin
    t = resources("template[#{wp_sql_admin_path}]")
  rescue
    Chef::Log.info("Could not find previously defined wp_sql_admin.sql resource")
    t = template wp_sql_admin_path do
      source "wp_add_admin.sql.erb"
      owner "root"
      group node['mysql']['root_group']
      mode "0600"
      action :create
    end
  end


execute "wp-set-theme" do
  command %Q["#{node['mysql']['mysql_bin']}" -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }"#{node['mysql']['server_root_password']}" --database "#{node['howto']['wp']['database']}" < "#{wp_sql_admin_path}"]
  action :run
end
