#
# Cookbook Name:: hoborglabs-dashboard
# Recipe:: code
#
# This checkots code for dashboard

# make sure some useful tools are installed
basePackages = %w[ git ant vim curl ]
case node['platform_family']
when 'rhel'
	# this is for ant symlink task
	basePackages << "ant-nodeps"
end
basePackages.each do |pkg|
	package pkg do
		action :install
	end
end

directory "#{node['hoborglabs-dashboard'][:code_root]}/example" do
	recursive true
	action :create
end

remote_directory "#{node['hoborglabs-dashboard'][:code_root]}/example" do
	source 'code-example'
	recursive true
	action :create
end

# Validate
# run as root, dashboard build.xml executes another ant for vendor/hoborglabs/dashbaord
# and for some reason the inner ant call thinks it's executed by root
execute "dashboard_validate" do
	cwd "#{node['hoborglabs-dashboard'][:code_root]}/example"
	command "ant validate.dev"
	only_if { ::File.exists?("#{node['hoborglabs-dashboard'][:code_root]}/example/build.xml") }
end

execute "chgrp to apache2 group" do
	command "chgrp -R #{node['apache']['group']} #{node['hoborglabs-dashboard'][:code_root]}/example"
end


link "#{node['hoborglabs-dashboard'][:code_root]}/current" do
	to "#{node['hoborglabs-dashboard'][:code_root]}/example"
end

# add symlink for vhost
link "/var/www/vhost/#{node['hoborglabs-dashboard'][:vhost][:server_name]}" do
	to "#{node['hoborglabs-dashboard'][:code_root]}/current"
end
