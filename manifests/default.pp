$jenkins_home = '/var/lib/jenkins'

class { 'apt':
}

class jenkinsinstance::jenkinsinstall {

  class { 'jenkinsinstance::jenkinsinstall::debs': } ->
  class { 'jenkinsinstance::jenkinsinstall::packages' : } ->
  class { 'jenkinsinstance::jenkinsinstall::java' : } ->
  class { 'jenkins' :
    repo                  => false,
    install_java          => false,
    plugin_hash           => {
      icon-shim                                                => { },
      ssh-agent                                                => { },
      script-security                                          => { },
      structs                                                  => { },
      junit                                                    => { },
      credentials                                              => { },
      copyartifact                                             => { },
      clone-workspace-scm                                      => { },
      ssh-credentials                                          => { },
      git                                                      => { },
      git-client                                               => { },
      git-server                                               => { },
      github-api                                               => { },
      mailer                                                   => { },
      matrix-project                                           => { },
      scm-api                                                  => { },
      job-dsl                                                  => { },
      parameterized-trigger                                    => { },
      jquery                                                   => { },
      jquery-detached                                          => { },
      ace-editor                                               => { },
      handlebars                                               => { },
      momentjs                                                 => { },
      dashboard-view                                           => { },
      build-pipeline-plugin                                    => { },
      github                                                   => { },
      token-macro                                              => { },
      delivery-pipeline-plugin                                 => { },
      build-blocker-plugin                                     => { },
      workflow-scm-step                                        => { },
      pipeline-stage-view                                      => { },
      pipeline-build-step                                      => { },
      workflow-durable-task-step                               => { },
      pipeline-stage-step                                      => { },
      workflow-api                                             => { },
      workflow-step-api                                        => { },
      workflow-support                                         => { },
      workflow-basic-steps                                     => { },
      pipeline-input-step                                      => { },
      pipeline-rest-api                                        => { },
      pipeline-stage-view                                      => { },
      workflow-job                                             => { },
      workflow-cps-global-lib                                  => { },
      workflow-cps                                             => { },
      workflow-multibranch                                     => { },
      workflow-aggregator                                      => { },
      branch-api                                               => { },
      cloudbees-folder                                         => { },
      matrix-auth                                              => { },
      durable-task                                             => { },
      antisamy-markup-formatter                                => { },
      maven-plugin                                             => { },
      javadoc                                                  => { },
      checkstyle                                               => { },
      analysis-cores                                            => { },
      swarm                                                    => { }
    }
  } ->
  class { 'jenkinsinstance::jenkinsinstall::jenkins_ssh_keygen' : }
}

class jenkinsinstance::jenkinsinstall::debs {
  $debian_update_site = 'http://ftp.nl.debian.org/debian/'
  $debian_security_update_site = 'http://ftp.nl.debian.org/debian-security/'

  apt::source { 'deb':
    location          => $debian_update_site,
    release           => "jessie",
    repos             => 'main',
    include_src       => true
  }

  apt::source { 'deb-updates':
    location          => $debian_update_site,
    release           => "jessie-updates",
    repos             => 'main',
    include_src       => true
  }

  apt::source { 'deb-security':
    location          => $debian_security_update_site,
    release           => "jessie/updates",
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

class jenkinsinstance::jenkinsinstall::jenkins_ssh_keygen {
  file{ "$jenkins_home/.ssh":
    owner    => "jenkins",
    group    => "jenkins",
    ensure   => 'directory'
  } ->
  ssh_keygen { 'jenkins':
    filename => "$jenkins_home/.ssh/id_rsa"
  } ->
  file { 'copy python web server' :
    path   => "$jenkins_home/public_key_server.py",
    ensure => 'present',
    source => '/vagrant/files/python/bin/public_key_server.py'
  } ->
  exec { 'start public key exposure' :
    command => 'python public_key_server.py &',
    path    => ['/usr/bin'],
    user    => 'jenkins',
    group   => 'jenkins',
    cwd     => $jenkins_home
  }

}

node default{
  class { 'jenkinsinstance::jenkinsinstall': }
  file { 'motd':
    path    => "/etc/motd",
    ensure  => present,
    mode    => 0640,
    content => hiera('motd_message'),
  }

}
