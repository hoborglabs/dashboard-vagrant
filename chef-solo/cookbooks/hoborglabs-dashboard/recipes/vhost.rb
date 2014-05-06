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
	server_name node['hoborglabs-dashboard'][:vhost][:server_name]
	server_aliases node['hoborglabs-dashboard'][:vhost][:server_aliases]
	docroot "/var/www/vhost/#{node['hoborglabs-dashboard'][:vhost][:server_name]}"
	directory_index "index.php"
	template "dashboard-vhost.conf.erb"
end
