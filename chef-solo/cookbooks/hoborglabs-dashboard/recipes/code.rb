#
# Cookbook Name:: hoborglabs-dashboard
# Recipe:: code
#
# This checkots code for dashboard

# we need GIT and ...
%w[git ant vim nodejs npm].each do |pkg|
	package pkg do
		action :install
	end
end

# add symlink for vhost
link node[:hoborglabs_dashboard][:vhost_folder] do
	to node[:hoborglabs_dashboard][:code_folder]
end
