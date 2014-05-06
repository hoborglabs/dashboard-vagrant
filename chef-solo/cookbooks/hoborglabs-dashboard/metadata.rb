name              'hoborglabs-dashboard'
license           'Apache 2.0'

version           '0.1.0'
recipe            'apache2', 'Main Apache configuration'
recipe            'apache2::logrotate', 'Rotate apache2 logs. Requires logrotate cookbook'
recipe            'apache2::mod_alias', 'Apache module "alias" with config file'

depends 'php'
depends 'apache2'
depends 'iptables'

supports 'debian'
supports 'centos'
supports 'ubuntu'

#supports 'amazon'
#supports 'arch'
#supports 'fedora'
#supports 'freebsd'
#supports 'redhat'
#supports 'scientific'
