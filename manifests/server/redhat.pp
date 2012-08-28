class mysql::server::redhat {
  include mysql::params

  package { 'mysql-server':
    ensure => installed,
  }

  file { $mysql::params::data_dir :
    ensure  => directory,
    owner   => 'mysql',
    group   => 'mysql',
    require => Package['mysql-server'],
  }

  file { '/etc/my.cnf':
    ensure  => present,
    path    => $mysql::params::mycnf,
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['mysql-server'],
  }

  file { '/etc/logrotate.d/mysql-server':
    ensure  => present,
    content => template('mysql/logrotate.redhat.erb'),
  }
}
