#
# Cookbook Name:: hoborglabs-dashboard
# Recipe:: default
#
# Creates new vhost

# create vhost folder
directory "/var/www/vhost" do
	owner "vagrant"
	group node['apache']['group']
	mode 0755
	action :create
end

# add apache vhost for dashboard
web_app "dashboard" do
	server_name "dashboard.dev"
	server_aliases ["www.dashboard.dev"]
	directory_index ["index.php"]
	docroot node[:hoborglabs_dashboard][:vhost_folder]
	directory_index "index.php"
	template "dashboard-vhost.conf.erb"
end
