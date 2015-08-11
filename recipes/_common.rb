#
# Cookbook Name:: uaitiphp
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# instala dependencias
package ['git', 'vim', 'nmap', 'unzip', 'mcrypt'] do
	action :install
end

# define o timezone
execute "timezone" do
	command "timedatectl set-timezone America/Sao_Paulo"
end
# instala o locale
execute "locale" do
	command "locale-gen pt_BR.utf8"
end

# cria o usuario
user node['uaitiphp']['server_user'] do
	home node['uaitiphp']['home_dir']
	shell '/bin/bash'
	manage_home true
	password '$1$o9erKayq$NV3zQGOeDZscp.mummdxZ.' # ubr0w53
	action [:create, :modify]
end
group 'adm' do
	members [node['uaitiphp']['server_user']]
	append true
	action :modify
end
group 'sudo' do
	members [node['uaitiphp']['server_user']]
	append true
	action :modify
end
# copia a chave ssh de deploy
directory node['uaitiphp']['home_dir'] + '/.ssh' do
	owner 'ubrowse'
	group 'ubrowse'
	action :create
end
template node['uaitiphp']['home_dir'] + "/.ssh/id_rsa.pub" do
	source "id_rsa.pub.erb"
	owner node['uaitiphp']['server_user']
	group node['uaitiphp']['server_user']
	mode '0644'
end
template node['uaitiphp']['home_dir'] + "/.ssh/id_rsa" do
	source "id_rsa.erb"
	owner node['uaitiphp']['server_user']
	group node['uaitiphp']['server_user']
	mode '0644'
end

# 
