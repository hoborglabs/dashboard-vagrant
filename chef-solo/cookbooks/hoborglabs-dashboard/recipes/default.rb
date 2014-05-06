#
# Cookbook Name:: hoborglabs-dashboard
# Recipe:: default
#

# make sure some useful tools are installed
%w[ curl ].each do |pkg|
	package pkg do
		action :install
	end
end

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


iptables_rule "http"
