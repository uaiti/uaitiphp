# UaiTI PHP+Nginx and MySQL servers setup

Este projeto possui uma série de scripts do Chef para poder instalar e configurar
o Nginx, PHP-FPM e MySQL.

Para utilizar, podem ser usadas as receitas **http_server** ou **mysql_server**:

```ruby
include_recipe "uaitiphp::http_server"
include_recipe "uaitiphp::mysql_server"
```

Para alterar as configurações, crie um arquivo de atributos com o seguinte conteúdo:
```ruby
# general server
node.default['uaitiphp']['project_name']    = 'project'
node.default['uaitiphp']['server_user']     = 'project'
node.default['uaitiphp']['home_dir']        = '/home/project'

# mysql
node.default['uaitiphp']['mysql_root_pass'] = 'changeme'

# httpd
node.default['uaitiphp']['server_name']     = 'project.com'
node.default['uaitiphp']['nginx_file']      = 'project.com'
node.default['uaitiphp']['webroot']         = 'webapp/webroot'
```
