#
# Cookbook Name:: hoborglabs-dashboard
# Recipe:: code-dev
#
# This checkots code for dashboard

# make sure some useful tools are installed
basePackages = %w[ git ant vim tree curl ]
case node['platform_family']
	when 'rhel'
		# this is for ant symlink task
		basePackages << "ant-nodeps"

		# phpunit dep
		basePackages << "php-domxml-php4-php5"
		basePackages << "php-pecl-xdebug"
end

codeRoot = node['hoborglabs-dashboard'][:code_root]

directory "#{node['hoborglabs-dashboard'][:code_root]}" do
	recursive true
	action :create
end

gitCfg = node['hoborglabs-dashboard'][:git]
git "#{node['hoborglabs-dashboard'][:code_root]}/dashboard-git" do
	revision gitCfg[:revision]
	remote gitCfg[:remote]
end

# Validate project if it's not already validated
execute "dashboard_validate" do
	cwd "#{node['hoborglabs-dashboard'][:code_root]}/dashboard-git"
	command "ant validate.dev"
	user "vagrant"
	not_if { ::File.exists?("#{node['hoborglabs-dashboard'][:code_root]}/dashboard-git/vendor/autoloader") }
end

# link "#{node['hoborglabs-dashboard'][:code_root]}/current" do
# 	to "#{node['hoborglabs-dashboard'][:code_root]}/example"
# end
