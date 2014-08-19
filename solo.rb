node_name "10.1.1.1"

base = File.expand_path('..', __FILE__)

nodes_path                File.join(base, 'nodes')
role_path                 File.join(base, 'roles')
data_bag_path             File.join(base, 'data_bags')
encrypted_data_bag_secret File.join(base, 'data_bag_key')
environment_path          File.join(base, 'environments')
environment               "_default"
ssl_verify_mode           :verify_none

cookbook_path []
cookbook_path << File.join(base, 'cookbooks-1') # /Users/myusername/.chefdk/gem/ruby/2.1.0/gems/knife-solo-0.4.2/lib/knife-solo/resources/patch_cookbooks
cookbook_path << File.join(base, 'cookbooks-2') # /Users/myusername/.berkshelf/knife-solo/2cbcbb32a9140c335af087b9b2f505f5458944a2
cookbook_path << File.join(base, 'cookbooks-3') # /Users/myusername/mykitchen/cookbooks

