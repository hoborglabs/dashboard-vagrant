#
# Cookbook Name:: hoborglabs-dashboard
# Recipe:: default
#

# make sure some useful tools are installed
%w[curl].each do |pkg|
	package pkg do
		action :install
	end
end

##
# Install apache and php

# add curl mod for php
node['php']['packages'] << "php5-curl"

include_recipe "apache2"
include_recipe "php"

include_recipe "hoborglabs-dashboard::vhost"
include_recipe "hoborglabs-dashboard::code"
