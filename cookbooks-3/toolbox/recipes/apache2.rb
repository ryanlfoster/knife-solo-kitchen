
 template "/etc/apache2/sites-available/toolbox" do
   source "apache2toolbox.erb"
   owner "root"
   group "sudo"
   mode "0644"
 end 

 execute "a2ensite" do
   command "a2ensite toolbox"
   action :run
 end

 service "apache2" do
   action :restart
 end
 
