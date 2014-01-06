# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# include some helpers
require File.expand_path('../vagrant-helpers', __FILE__)

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# Every Vagrant virtual environment requires a box to build off of.
	config.vm.box = "precise64"

	# The url from where the 'config.vm.box' box will be fetched if it
	# doesn't already exist on the user's system.
	config.vm.box_url = "http://files.vagrantup.com/precise64.box"

	# Create a forwarded port mapping which allows access to a specific port
	# within the machine from a port on the host machine.
	config.vm.network :forwarded_port, guest: 80, host: 8080
	config.vm.network :forwarded_port, guest: 443, host: 8443

	# get local config from VagrantConfig file
	cfg = getConfig

	# Provider-specific configuration so you can fine-tune various
	# backing providers for Vagrant.
	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--memory", cfg[:memory]]
		vb.customize ["modifyvm", :id, "--cpus", cfg[:cores]]
	end

	# add shared folder
	content = location(:code_dashboard, "~/workspace/dashboard/")
	config.vm.synced_folder content, "/var/code/dashboard"
	hack_rc = location(:code_hack, "~/workspace/remote-dashing/")
	config.vm.synced_folder hack_rc, "/var/code/remote-dashing"

	# Enable provisioning with chef solo, specifying a cookbooks path, roles
	# path, and data_bags path (all relative to this Vagrantfile), and adding
	# some recipes and/or roles.
	config.vm.provision :chef_solo do |chef|
		# different machines, different ssh key names
		key_type = cfg[:keyType].nil? ? "r" : cfg[:keyType]

		chef.cookbooks_path = ["./chef-solo/cookbooks", "./vendor/opscode/cookbooks"]
		chef.roles_path = "./chef-solo/roles"
		chef.add_role "gamesys-dashboard"
		chef.json = {
			:user => {
				:name => `whoami`.strip,
				:public_key => readfile('~/.ssh/id_' + key_type + 'sa.pub'),
				:private_key => readfile('~/.ssh/id_' + key_type + 'sa'),
				:vimrc => readfile('~/.vimrc'),
				:gitconfig => readfile('~/.gitconfig'),
			},
			:gamesys => {
				:dashboard => {
					:git_checkout => cfg[:git_checkout],
					:git_config => cfg[:git_config]
				}
			}
		}
	end
end



