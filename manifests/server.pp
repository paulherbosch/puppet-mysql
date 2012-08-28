class mysql::server {
  case $::operatingsystem {
      redhat, centos: { include mysql::server::redhat }
      default: { fail("${::operatingsystem} is not yet supported") }
  }
}
