# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "scotch/box"
  config.vm.network "private_network", ip: "192.168.33.12"
  config.vm.hostname = "scotchbox4dev"
  config.vm.synced_folder ".", "/var/www", :mount_options => ["dmode=777", "fmode=666"]

  config.vm.provider "virtualbox" do |v|
    v.memory = 512
    # v.cpus = 2
  end
end
