# UaiTI PHP+Nginx and MySQL servers setup

Este projeto possui uma série de scripts do Chef para poder instalar e configurar
o Nginx, PHP-FPM e MySQL.

Para utilizar, podem ser usadas as receitas **http_server** ou **mysql_server**:

```ruby
include_recipe "uaitiphp::http_server"
include_recipe "uaitiphp::mysql_server"
```


