class { 'apt':
  always_apt_update    => true,
  update_timeout       => undef,
  purge_sources_list   => true
}

class officestats::jenkinsinstall {

  class { 'officestats::jenkinsinstall::debs': } ->
  class { 'java':
    distribution => 'jdk'
  } ->
  class { 'jenkins' :
    repo         => false,
    install_java => false,
    plugin_hash  => {
      ssh-agent => { },
      credentials =>  { },
      git => { },
      git-client => { },
      job-dsl => { }
    }
  }
}

class officestats::jenkinsinstall::debs {

  apt::source { 'deb':
    location          => 'http://ftp.nl.debian.org/debian/',
    release           => "wheezy",
    repos             => 'main',
    include_src       => true
  }

  apt::source { 'deb-updates':
    location          => 'http://ftp.nl.debian.org/debian/',
    release           => "wheezy-updates",
    repos             => 'main',
    include_src       => true
  }

  apt::source { 'deb-security':
    location          => 'http://ftp.nl.debian.org/debian-security/',
    release           => "wheezy/updates",
    repos             => 'main',
    include_src       => true
  }

  apt::source { 'jenkins':
    location    => 'http://pkg.jenkins-ci.org/debian',
    release     => 'binary/',
    repos       => '',
    key         => 'D50582E6',
    key_source  => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
    include_src => false,
  }

}

node default{

  class { 'officestats::jenkinsinstall': }
  package{ 'git-core':
    ensure => 'installed'
  }

}