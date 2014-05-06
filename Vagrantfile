# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# include some helpers
require File.expand_path('../vagrant/config', __FILE__)

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# Every Vagrant virtual environment requires a box to build off of.
	config.vm.box = "CentOS 6.4 x86_64"

	# The url from where the 'config.vm.box' box will be fetched if it
	# doesn't already exist on the user's system.
	#config.vm.box_url = "http://files.vagrantup.com/precise64.box"
	config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20131103.box"

	# get local config from VagrantConfig file
	cfg = getConfig

	# Create a forwarded port mapping which allows access to a specific port
	# within the machine from a port on the host machine.
	config.vm.network :forwarded_port, guest: 80, host: cfg[:portOffset] + 80
	config.vm.network :forwarded_port, guest: 443, host: cfg[:portOffset] + 443

	# Provider-specific configuration so you can fine-tune various
	# backing providers for Vagrant.
	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--memory", cfg[:memory]]
		vb.customize ["modifyvm", :id, "--cpus", cfg[:cores]]
	end

	# add shared folder
	config.vm.synced_folder(
			location(cfg[:code_dashboard] || "~/workspace/dashboard/"),
			"/var/code/dashboard")

	# Enable provisioning with chef solo, specifying a cookbooks path, roles
	# path, and data_bags path (all relative to this Vagrantfile), and adding
	# some recipes and/or roles.
	config.vm.provision :chef_solo do |chef|
		chef.cookbooks_path = ["./chef-solo/cookbooks", "./opscode/cookbooks"]
		chef.roles_path = "./chef-solo/roles"
		chef.add_role "hoborglabs-dashboard"
		chef.json = {
			:hoborglabs => {
				:user => {
					:name => `whoami`.strip,
					:public_key => readfile(cfg[:sshKey] + '.pub'),
					:private_key => readfile(cfg[:sshKey]),
					:vimrc => cfg[:vim_config] ? readfile('~/.vimrc') : nill,
					:gitconfig => cfg[:git_config] ? readfile('~/.gitconfig') : nill,
				},
				:dashboard => {
				}
			}
		}
	end
end

# used by ./vagrant/config.rb to get config file name
def configFile()
	File.expand_path('VagrantConfig')
end
