#
# Cookbook Name:: hoborglabs-dashboard
# Attributes:: hoborglabs_dashboard


default['hoborglabs-dashboard'] = {
	:code_root => '/var/code/',
	:vhost => {
		:server_name => 'dashboard.dev',
		:server_aliases => ['www.dashboard.dev'],
	}
	:git => {
		:revision => 'develop',
		:remote => 'git@github.com:hoborglabs/dashboard.git'
	}
}
