# == Class: lemmus
#
# Full description of class lemmus here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { lemmus:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Atze De Vries <atze.devries@naturalis.nl>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class lemmus {
  
  package {'python-pip':
    ensure => installed,
  }

  pip { 'sh':
    require => Package['python-pip'],
  }
  
  pip { 'PyGitHub': 
    require => Package['python-pip'],  
  }

  vcsrepo { '/opt/lemmus':
    ensure => latest,
    provider => 'git',
    source => 'https://github.com/naturalis/lemmus.git'
  }
  
  file {'/usr/bin/lemmus':
    ensure => 'link',
    target => '/opt/lemmus/lemmus.py'
  }
}
