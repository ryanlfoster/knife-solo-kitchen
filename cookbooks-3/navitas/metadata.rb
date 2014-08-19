name             'navitas'
maintainer       'AKQA'
maintainer_email 'jon.barber@akqa.com'
license          'All rights reserved'
description      'Installs/Configures navitas'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.2'

%w{ tomcat simple_iptables varnish mysql }.each do |cb|
  depends cb
end

%w{ debian ubuntu centos redhat fedora }.each do |os|
  supports os
end

recipe "navitas::tomcat", "Installs and configures Tomcat"
