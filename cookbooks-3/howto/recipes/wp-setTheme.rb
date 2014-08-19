
#sql_script_path = node['howto']['wp']['sql_theme_path'].to_s

wp_theme_path = node['howto']['wp_theme_path']

  begin
    t = resources("template[#{wp_theme_path}]")
  rescue
    Chef::Log.info("Could not find previously defined setTheme.sql resource")
    t = template wp_theme_path do
      source "wp_set_theme.sql.erb"
      owner "root"
      group node['mysql']['root_group']
      mode "0600"
      action :create
    end
  end


execute "wp-set-theme" do
  command %Q["#{node['mysql']['mysql_bin']}" -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }"#{node['mysql']['server_root_password']}" --database "#{node['howto']['wp']['database']}" < "#{wp_theme_path}"]
  action :run
end
