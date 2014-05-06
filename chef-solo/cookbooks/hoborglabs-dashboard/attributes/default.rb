#
# Cookbook Name:: hoborglabs-dashboard
# Attributes:: hoborglabs_dashboard


default['hoborglabs-dashboard'] = {
	:code_root => '/var/code/',
	:version => 'master',
	:vhost => {
		:server_name => 'dashboard.dev',
		:server_aliases => ['www.dashboard.dev'],
	}
}
