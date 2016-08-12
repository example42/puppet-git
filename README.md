# Deprecation notice

This module was designed for Puppet versions 2 and 3. It should work also on Puppet 4 but doesn't use any of its features.

The current Puppet 3 compatible codebase is no longer actively maintained by example42.

Still, Pull Requests that fix bugs or introduce backwards compatible features will be accepted.


# Puppet module: git

This is a Puppet module for git
It provides only package installation and file configuration.

Based on Example42 layouts by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-git

Released under the terms of Apache 2 License.

This module requires the presence of Example42 Puppi module in your modulepath.


## USAGE - Basic management

* Install git with default settings

        class { 'git': }

* Clone a git repo to a local directory

        git::reposync { 'my_app':
          source_url      => 'http://repo.example42.com/git/trunk/my_app/',
          destination_dir => '/opt/myapp',
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file

        class { 'git':
          source => [ "puppet:///modules/example42/git/git.conf-${hostname}" , "puppet:///modules/example42/git/git.conf" ], 
        }

* Use custom template for main config file. Note that template and source arguments are alternative.

        class { 'git':
          template => 'example42/git/git.conf.erb',
        }

* Automatically include a custom subclass

        class { 'git':
          my_class => 'example42::my_git',
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-git.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-git]
