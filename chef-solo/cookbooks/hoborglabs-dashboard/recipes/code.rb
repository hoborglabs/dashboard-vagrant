#
# Cookbook Name:: hoborglabs-dashboard
# Recipe:: code
#
# This checkots code for dashboard

# we need GIT and ...
%w[git ant vim].each do |pkg|
	package pkg do
		action :install
	end
end

# add symlink for vhost
link node[:hoborglabs_dashboard][:vhost_folder] do
	to node[:hoborglabs_dashboard][:code_folder]
end

# validate
# run as root, dashboard build.xml executes another ant for vendor/hoborglabs/dashbaord
# and for some reason the inner ant call thinks it's executed by root
execute "dashboard_validate" do
	cwd node[:hoborglabs_dashboard][:code_folder]
	command "ant validate"
end