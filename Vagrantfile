# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"

  config.vm.provider 'virtualbox' do |vbx|
    vbx.linked_clone = true
    vbx.customize ['modifyvm', :id, '--audio', 'none']
  end

  config.vm.define "qacode" do |demo|
    demo.vm.network "private_network", ip: "192.168.34.14"
  end

  config.vm.provision "shell",
  name: "packages deployment",
  path: "deploy.sh"

end



