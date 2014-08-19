maintainer        "AKQA"
maintainer_email  "jon.barber@akqa.com"
license           "Apache 2.0"
description       "Installs and configures the Adobe Dispatcher Apache module, along with Apache 2"
version           "0.0.6"

%w{redhat centos scientific fedora debian ubuntu arch freebsd amazon}.each do |os|
  supports os
end

depends "apache2"