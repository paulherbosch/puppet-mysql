class mysql::server::redhat {
  include mysql::params

  case $mysql::params::real_instance_type {
    small: { include mysql::config::performance::small }
    medium: { include mysql::config::performance::medium }
    large: { include mysql::config::performance::large }
    default: { fail('Unknown instance type') }
  }

  package { 'mysql-server':
    ensure => installed,
  }

  service { $mysql::params::myservice:
    ensure      => running,
    enable      => true,
    hasrestart  => true,
    hasstatus   => true,
    require     => Package['mysql-server'],
  }

  file { $mysql::params::real_data_dir :
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
