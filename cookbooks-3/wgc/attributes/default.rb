# nginx ssl bindings
default['wgc']['client_host'] = "www.dev.wgc.akqa.net"
default['wgc']['client_ssl_port'] = 443
# varnish reverse proxy origin server
default['wgc']['origin_ip'] = "192.168.16.131"
default['wgc']['origin_host'] = "www.dev.wgc.akqa.net"
default['wgc']['origin_http_port'] = 80
default['wgc']['origin_http_port_for_ssl'] = 443
default['wgc']['varnish_grace'] = "2m"
default['wgc']['varnish_saint_grace'] = "1h"
default['wgc']['varnish_cache_ttl'] = "5m"
# ssl certs location for nginx
default['wgc']['cert_path'] = "/etc/ssl"

