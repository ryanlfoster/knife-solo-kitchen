name             'project.titanscape'
maintainer       'AKQA'
maintainer_email 'regardt.meyer@akqa.com'
license          'All rights reserved'
description      'Installs/Configures titanscape'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

%w{ simple_iptables varnish }.each do |cb|
  depends cb
end

%w{ debian ubuntu centos redhat fedora }.each do |os|
  supports os
end
