# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.provider "virtualbox" do |v|
    v.name = "power-center-vm"
    v.memory = 2048
    v.cpus = 2
  end

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "chef/centos-7.0"
  # config.vm.box = "nrel/CentOS-6.5-x86_64"
  # config.vm.box = "centos/7"

  # CREATE UNIQUE HOSTNAME HERE SO THAT IT DOES NOT DEFAULT TO localhost.localdomain.
  config.vm.hostname = "Integra-521"

  # ~~~ Vagrant-VbGuest addon ~~
  # we will try to autodetect this path.
  # However, if we cannot or you have a special one you may pass it like:
  # config.vbguest.iso_path = "#{ENV['HOME']}/Downloads/VBoxGuestAdditions.iso"
  # or
  # config.vbguest.iso_path = "http://company.server/VirtualBox/%{version}/VBoxGuestAdditions.iso"

  # set auto_update to false, if you do NOT want to check the correct
  # additions version when booting this machine
  config.vbguest.auto_update = false

  # do NOT download the iso file from a webserver
  config.vbguest.no_remote = false

  # config.vm.provision "shell", path: "increase_swap.sh"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # forward Tomcat port for Infaagent.
  config.vm.network "forwarded_port", guest: 1521, host: 1521

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  
  # Install Puppet and vim
  config.vm.provision "shell", inline: <<-SHELL
    echo "Installing Puppet"
    rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
    yum install puppet -y
    echo "Installing vim...\n" && yum install vim -y
    echo "Installing gzip2" && yum install bzip2 -y
  SHELL

  # Install Curl and Unzip are installed for the vagrant-jenv plugin to work
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "provision/puppet/manifests"
    puppet.manifest_file = "site.pp"
  end

  # Install Java, Ant and Maven
  config.vm.provision :jenv do |jenv|
    jenv.candidates = [
      'java 1.7.0_25',   # Informatica ESB compliant
    ]
  end

  # Install Oracle XE 11G
  config.vm.provision "shell", path: "oracle_setup.sh"
  
  # Install Power Center
  # config.vm.provision "shell", path: "power_center_setup.sh"

  # # Install htop for fancy monitoring ($ htop) and libaio
  # config.vm.provision "shell", inline: <<-SHELL
  #   yum install epel-release -y
  #   yum install htop -y
  #   yum install libaio -y
  #   yum install bc -y
  # SHELL

  config.vm.provision "shell", inline: <<-SHELL
    echo 'cd /vagrant' >> /home/vagrant/.bashrc
    # echo 'ln -s /home/vagrant/.jenv/candidates/java/current/bin/ java_bin' >> /home/vagrant/.bashrc
  SHELL

end
