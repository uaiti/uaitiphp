#
# Cookbook Name:: uaitiphp
# Recipe:: mysql_server
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'uaitiphp::_common'

package ['git', 'php-pear', 'mysql-server-5.5', 'mysql-client', 'php5-mysql', 'php5-cli', 'vim', 'php5-curl', 'nmap', 'nginx', 'php5-fpm', 'php5-mysql'] do
        action :install
end

# instala o mysql
mysql_service node['uaitiphp']['project_name'] do
	initial_root_password node['uaitiphp']['mysql_root_pass']
	bind_address '0.0.0.0'
	action [:create, :start]
end

