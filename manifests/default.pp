class { 'apt':
  always_apt_update    => true,
  update_timeout       => undef,
  purge_sources_list   => true
}

class jenkinsinstance::jenkinsinstall {

  class { 'jenkinsinstance::jenkinsinstall::debs': } ->
  class { 'jenkinsinstance::jenkinsinstall::packages' : } ->
  class { 'jenkinsinstance::jenkinsinstall::java' : } ->
  class { 'jenkins' :
    repo                  => false,
    install_java          => false,
    plugin_hash           => {
      ssh-agent             => { } ,
      credentials           =>  { } ,
      ssh-credentials    => { },
      git                   => { } ,
      git-client            => { } ,
      github-api => { },
      scm-api => { },
      job-dsl               => { } ,
      parameterized-trigger => { } ,
      jquery                => { } ,
      dashboard-view => { },
      build-pipeline-plugin => { },
      github => { },
      build-blocker-plugin => { },
      swarm => { }
    }
  }
}

class jenkinsinstance::jenkinsinstall::debs {

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

class jenkinsinstance::jenkinsinstall::packages {
  package{ ['git-core','maven']:
    ensure => 'installed'
  }
}

class jenkinsinstance::jenkinsinstall::java {
  package { 'openjdk-7-jdk':
    ensure => 'present'
  }
}

node default{

  class { 'jenkinsinstance::jenkinsinstall': }

}
