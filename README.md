# Jenkins instance

This project is a vagrant/puppet instance for a Jenkins installation. With this script you'll be able to create a Jenkins VM within minutes.

## Prerequisite

These items are needed before starting/creating a new Jenkins instance:

- Internet connection
- Latest virtual box version (tested with 4.3.12)
- Latest vagrant version (1.6.3)
- Vagrant librarian puppet installed ([Instructions here](https://github.com/mhahn/vagrant-librarian-puppet))

## Starting the instance

The following commands starts the Jenkins instance. (You need to be in the top directory of the project)

``` bash
vagrant up
```
### After starting the Jenkins instance

After starting the Jenkins instance not all the plugins are loaded correctly, this is caused by outdated plugins 
bootstrapped with the default Jenkins installation. You can update these by using this [link](http://33.33.33.30:8080/pluginManager/)

### Bootstrapping additional Jenkins plugins

You can bootstrap extra Jenkins plugins by adding them to the Puppet manifest [/manifests/default.pp](/manifests/default.pp).
Full details of the usage of the Puppet Jenkins plugin can be found [here](https://github.com/jenkinsci/puppet-jenkins)

## Manual steps

The following steps need to be done manually, these steps can be done in the 'Manage Jenkins -> Configure System' menu option

- Install JDK and accept the license
- Install a Maven version
