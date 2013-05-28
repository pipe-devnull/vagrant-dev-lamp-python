###########################################
# Simple DEV lampstack
#
# - Base set up
# - Apahce, Mysql, Python & some 
#   basic utils
#
###########################################


###########################################
# Initialize environment
###########################################
class init {
  exec { 'apt-get updatec':
    command => '/usr/bin/apt-get update'
  }
}

###########################################
# Python installation & base extensions 
# - uses distributions default version
###########################################
class python {

  # Installs Python, mopd python and restart Apache
  package { ['python', 'python-pip', 'libapache2-mod-wsgi','libapache2-mod-python']:
    ensure  => installed,
    notify  => Service['apache2'],
  }

}


###########################################
# Some basic utils I like having available 
###########################################
class util {

  package { "curl":
    ensure  => present,
  }

  package { "vim":
    ensure  => present,
  }

  package { "tree":
    ensure  => present,
  }

}

###########################################
# Basic apache installation & VHOST setup 
# using vhost file in vagrant-dev/conf
###########################################
class vhostsetup {

   apache::vhost { 'default':
      docroot             => '/vagrant/www',
      server_name         => 'lampdev',
      server_admin        => 'webmaster@locahost',
      docroot_create      => true,
      priority            => '',
      template            => 'apache/virtualhost/vhost.conf.erb',
  }

}

include init
include apache
include mysql
include python
include vhostsetup
include util
