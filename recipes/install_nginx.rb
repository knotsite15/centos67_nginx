#
# Cookbook Name:: centos67_nginx
# Recipe:: install_nginx
#
# Copyright (c) 2016 The Authors, All Rights Reserved. 

include_recipe 'nginx::repo'

package 'nginx' do
  action :install
end



service 'nginx' do
  supports status: true, restart: true, reload: true
  action :enable
end

