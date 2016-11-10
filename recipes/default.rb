#
# Cookbook Name:: centos67_nginx
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


include_recipe 'yum::default'

include_recipe 'centos67_nginx::install_nginx'



