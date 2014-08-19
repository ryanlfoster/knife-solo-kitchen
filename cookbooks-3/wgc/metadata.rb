name             'wgc'
maintainer       'akqa'
maintainer_email 'michael.carlisle@akqa.com'
license          'All rights reserved'
description      'Installs/Configures wgc'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ simple_iptables varnish nginx }.each do |cb|
  depends cb
end

%w{ debian ubuntu centos redhat fedora }.each do |os|
  supports os
end
