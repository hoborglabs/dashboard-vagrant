#
# Cookbook Name:: hoborglabs-dashboard
# Recipe:: default
#

# Add additional packages.
case node['platform_family']
when 'debian'
	node.default['php']['packages'] << "php5-curl"
end

# Install apache and php
include_recipe "apache2"
include_recipe "php"

include_recipe "hoborglabs-dashboard::vhost"
include_recipe "hoborglabs-dashboard::code"

# Open HTTP ports
iptables_rule "http"
