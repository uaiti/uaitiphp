#
# Cookbook Name:: uaitiphp
# Recipe:: mysql_server
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'uaitiphp::_common'

package ['git', 'php-pear', 'mysql-server-5.5', 'mysql-client', 'php5-mysql', 'php5-cli', 'vim', 'php5-curl', 'nmap', 'nginx', 'php5-fpm', 'php5-mysql'] do
        action :install
end

service 'nginx' do
	supports :status => true, :restart => true, :reload => true
end


# instala o mysql
mysql_service node['uaitiphp']['project_name'] do
	initial_root_password node['uaitiphp']['mysql_root_pass']
	bind_address '0.0.0.0'
	action [:create, :start]
end

mysql_config node['uaitiphp']['project_name'] do
  source 'mysql-config.erb'
  notifies :restart, 'mysql_service[' + node['uaitiphp']['project_name'] + ']'
  action :create
end


# configura o ping do mysql
directory '/var/www/html/' do
	owner node['uaitiphp']['server_user']
	group node['uaitiphp']['server_user']
	mode '0755'
	recursive true
	action :create
end

template '/etc/nginx/sites-enabled/' + node['uaitiphp']['mysql_nginx_file'] do
	source 'mysql-ping.erb'
end
template '/etc/nginx/sites-enabled/default' do
	source 'default.erb'
	manage_symlink_source true
	notifies :reload, 'service[nginx]', :immediately
end

template "/var/www/html/mysql-ping.php" do
	source 'mysql-ping.php.erb'
end

# executa o arquivo com configurações iniciais
template '/tmp/initdb.sql' do
	source 'initdb.sql.erb'
end
execute 'load_database' do
	ignore_failure true
	command 'mysql -u root -h 127.0.0.1 -p' + node['uaitiphp']['mysql_root_pass'] + ' < /tmp/initdb.sql'
end