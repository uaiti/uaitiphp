#
# Cookbook Name:: uaitiphp
# Recipe:: http_server
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'uaitilinuxserver'

package ['nginx', 'php5', 'php5-fpm', 'php-pear', 'php5-mysql', 'mysql-client', 'php5-curl', 'php5-intl', 'php5-mcrypt'] do
	action :install
end

service 'nginx' do
	supports :status => true, :restart => true, :reload => true
end
service 'php-fpm' do
	supports :status => true, :restart => true
end

# template de configuracao do servidor http
directory '/var/www/html/' + node['uaitiphp']['project_name'] do
	owner node['uaitilinuxserver']['server_user']
	group node['uaitilinuxserver']['server_user']
	mode '0755'
	recursive true
	action :create
end

template '/etc/nginx/sites-enabled/' + node['uaitiphp']['nginx_file'] do
	source 'project.erb'
end
template '/etc/nginx/sites-enabled/default' do
	source 'default.erb'
	manage_symlink_source true
	notifies :reload, 'service[nginx]', :immediately
end


# instala o nvm / nodejs
node.default['nodejs']['install_method'] = 'package'
include_recipe 'nodejs::npm'
nodejs_npm 'bower'
nodejs_npm 'grunt-cli'


# instala o phing
phingc = php_pear_channel 'pear.phing.info' do
	action :discover
end
php_pear 'phing' do
	channel phingc.channel_name
	action :install
end


# instala o composer
node.default['composer']['install_globally'] = true
include_recipe "composer"
composer_project '/var/www/html/' + node['uaitiphp']['project_name'] do
	quiet false
	action :install
end
