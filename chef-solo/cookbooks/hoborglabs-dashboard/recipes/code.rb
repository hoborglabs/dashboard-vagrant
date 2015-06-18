#
# Cookbook Name:: hoborglabs-dashboard
# Recipe:: code
#
# This checkots example project for dashboard ready for use

# make sure some useful tools are installed
basePackages = %w[ git ant vim curl ]
case node['platform_family']
	when 'rhel'
		# this is for ant symlink task
		basePackages << "ant-nodeps"
end

basePackages.each do |pkg|
	package pkg
end

codeRoot = node['hoborglabs-dashboard'][:code_root]

directory "#{codeRoot}/example-app" do
	recursive true
	action :create
end

remote_directory "#{codeRoot}/example-app" do
	source 'code-example'
	recursive true
	action :create
end

# Validate
# run as root, dashboard build.xml executes another ant for vendor/hoborglabs/dashbaord
# and for some reason the inner ant call thinks it's executed by root
execute "dashboard_validate" do
	cwd "#{codeRoot}/example-app"
	command "ant validate"
	only_if { ::File.exists?("#{codeRoot}/example-app/build.xml") }
end

execute "fix_group" do
	command "chgrp -R '#{node['apache']['group']}' '#{codeRoot}/example-app'"
end

# link current version
link "#{codeRoot}/#{node['hoborglabs-dashboard'][:vhost][:server_name]}" do
	to "#{codeRoot}/example-app"
end

# connect to apache vhost
link "/var/www/vhost/#{node['hoborglabs-dashboard'][:vhost][:server_name]}" do
	to "#{codeRoot}/#{node['hoborglabs-dashboard'][:vhost][:server_name]}"
end
