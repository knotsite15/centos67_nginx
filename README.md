# centos67_nginx

Setting up NGINX on CentOS 6.7 using chef

PREREQUISITES:

Chef Development Kit Version: 0.15.15
chef-client version: 12.11.18
Vagrant: 1.8.1
VirtualBox 5.0

INSTALLING:



1.	Install VirtualBox 5.0 
https://www.virtualbox.org/wiki/Download_Old_Builds_5_0

Download the VirtualBox from the above link and run the installer.

Follow the steps through the installer for completing the installation.

2.	Install Vagrant
https://coolestguidesontheplanet.com/getting-started-vagrant-os-osx-10-9-mavericks/

Downloaded the centOS6.7 image from the above link.

Run the below command to setup vagrant.

Vagrant box add centos67 http://developer.nrel.gov/doenloads/vagrant-boxes/CentOS-6.7
               Vagrant init centos67
               Vagrant up

When I was setting up the vagrant, I had some issues with VirtualBox guest additions.

Error:
The guest additions on this VM do not match the installed versions of default VitualBox

Fix:
I installed a plugin called “vagrant-vbguest”, which automatically checks for and install the correct guest additions automatically.

3.	Install ChefDK:
Download chef from below link.
https://downloads.chef.io/chef-dk/mac/
check ruby and gem
which ruby -> /opt/chefdk/embedded/bin/ruby
which gem -> /opt/chefdk/embedded/bin/gem

echo $GEM_PATH should provide you the below result.
/Users/niruthya.venkatesan/.chefdk/gem/ruby/2/1/0:/opt/chefdk/embedded/lib/ruby/gems/2/1/0
Check version:
Knife -v
Kitchen -v
Chef -v
Install bundler:

Gem install bundler
4.	Install vagrant plugins:
Vagrant plugin install vagrant-omnibus
Vagrant plugin install vagrant-berkshelf
Vagrant plugin install vagrant-hostmanager

5.	Creating cookbook
chef generate cookbook centos67_nginx
cd centos67_nginx
6.	Ensuring the yum cache is the latest version

To get the latest version, use the below command

Chef exec knife cookbook site cookbook site show yum | grep latest_version

Add the latest version to the metadata.rb file.

Depends ‘yum’, ‘= 4.1.0’

7.	Add the yum::default recipe to recipes/default.rb file
Include_recipe ‘yum::default’

8.	Test
Chef exec berks install
This command generates Berksfile.lock file.
9.	Configuring NGINX
We need nginx cookbook for the nginx repo.
Add the below line to metadata.rb.
Depends ‘nginx’, ‘= 2.7.6’

10.	Create the install_nginx.rb recipe file.
Add the following piece of code into the file
include_recipe ‘nginx::repo’

package ‘nginx’ do
  action :install
end
service ‘nginx’ do
    supports status: true, restart: true, reload: true
    action :enable
end
11.	Setting the install_nginx recipe to run.
Include the below line in centos67_nginx/recipes/default.rb

Include_recipe ‘centos67_nginx::install_nginx’
12.	Integration test
Add the below piece of code in 
Centos67_nginx/test/integration/default/serverspec/default_spec.rb

Require ‘spec_helper’
         Describe ‘centos67_nginx::default’ do
Describe package(‘nginx’) do
  It{ should be_installed }
End
Describe service(‘nginx’) do
     It {  should be_enable  }
     It {  should be_running  }
End
        End
13.	Test
Ruby Lint
Run the below command

Chef exec rubocop

Chef Lint

Chef exec foodcritic .

14.	Unit testing
Run the below command
Chef exec berks install

Create .rspec file.
Touch .rspec
Enter the below piece of code into the file

--color
--format documentation

Run:

Chef exec rspec
15.	Integration testing
Update the .kitchen.yml file to include the centos platform.
Add the below line of code into the file
Platforms:
-	Name: CentOS-6.7

16.	Run the integration test
              Run the below command.
              Chef exec kitchen test –destroy=never


