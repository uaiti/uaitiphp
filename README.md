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

# mysql
node.default['uaitiphp']['mysql_root_pass'] = 'changeme'

# httpd
node.default['uaitiphp']['server_name']     = 'project.com'
node.default['uaitiphp']['nginx_file']      = 'project.com'
node.default['uaitiphp']['webroot']         = 'webapp/webroot'
```

# Alterando o script de inicialização do banco de dados

Caso queira alterar o script de inicialização utilizado no recipe **mysql_server**, você pode criar um arquivo na pasta **templates/default** com o nome de **initdb.sql.erb** com o conteúdo que você quer. Para fazer o chef utilizar o seu novo template, basta fazer o seguinte:
```ruby
resources("template[/tmp/initdb.sql]").cookbook = 'nome-do-seu-cookbook'
```
