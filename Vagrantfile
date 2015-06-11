#!/usr/bin/env ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

 config.vm.box = "debian-8.1-lxc-puppet"
 config.vm.box_url = "https://dl.dropboxusercontent.com/u/3523744/boxes/debian-8.1-amd64-lxc-puppet/debian-8.1-lxc-puppet.box"

 config.vm.provider "virtualbox" do |v|
   v.memory = 1024
   v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
 end

 config.librarian_puppet.puppetfile_dir = "puppet"
 config.librarian_puppet.placeholder_filename = ".MYPLACEHOLDER"
 config.vm.provision :shell, :path => "shell/main.sh"

 config.vm.define "jenkins" do |jenkins|
   jenkins.vm.network "private_network", ip: "33.33.33.30"
   jenkins.vm.network "forwarded_port", guest: 8080, host: 8080
   jenkins.vm.provision "puppet" do |puppet|
     puppet.hiera_config_path = "hiera/hiera.yaml"
   end
 end

end
