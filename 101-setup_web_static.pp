# Setup web servers for deployment of AirBnb_clone
package { 'nginx':
  ensure => installed,
}
file { '/data':
  ensure => 'directory',
  owner  => 'ubuntu',
  group  => 'ubuntu',
}
file { '/data/web_static':
  ensure => 'directory',
  owner  => 'ubuntu',
  group  => 'ubuntu',
}
file { '/data/web_static/releases':
  ensure => 'directory',
  owner  => 'ubuntu',
  group  => 'ubuntu',
}
file { '/data/web_static/shared':
  ensure => 'directory',
  owner  => 'ubuntu',
  group  => 'ubuntu',
}
file { '/data/web_static/releases/test':
  ensure => 'directory',
  owner  => 'ubuntu',
  group  => 'ubuntu',
}
file { '/data/web_static/releases/test/index.html':
  ensure  => 'file',
  content => '<html>\n  <head>\n  </head>\n  <body>\n    Holberton School\n  </body>\n</html>\n',
  owner   => 'ubuntu',
  group   => 'ubuntu',
}
file { '/data/web_static/current':
  ensure => 'link',
  target => '/data/web_static/releases/test',
  owner  => 'root',
  group  => 'root',
}
file { '/etc/nginx/sites-available/default':
  ensure  => 'file',
  content => "server {\n\tlisten 80;\n\tlisten [::]:80;\n\tserver_name _;\n\n\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t}\n}\n",
  owner   => 'root',
  group   => 'root',
  notify  => Service['nginx'],
}
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => File['/etc/nginx/sites-available/default'],
}
