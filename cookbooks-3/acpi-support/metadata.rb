maintainer        "AKQA"
maintainer_email  "jon.barber@akqa.com"
license           "All rights reserved"
description       "Installs ACPI support"
version           "0.0.3"

%w{ debian ubuntu }.each do |os|
  supports os
end

