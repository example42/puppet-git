# = Define: git::clone
#
# Clone a git repository if it does not exist yet. Will not do anything
# if the clone already exists.
#
# == Parameters
#
# [*ensure*]
#   Define if the git_reposync script and eventual cron job
#   must be present or absent. Default: present.
#
# [*source_url*]
#   Url of the repository to use. As passed to the git command. Required.
#
# [*destination_dir*]
#   Local directory where to clone the repository. Required.
#
# [*creates*]
#   Path of a file or directory created by the git command. If it
#   exists Puppet will not clone the repo.
#   Default: $destination_dir.
#
# [*extra_options*]
#   Optional extra options to add to git command. Default: ''.
#
# [*branch*]
#   Optional branch name
#
# [*owner*]
#   Owner of the cloned repo.
#
define git::clone (
  $source_url,
  $destination_dir,
  $ensure        = 'present',
  $creates       = $destination_dir,
  $extra_options = '',
  $branch        = $git::default_branch,
  $owner         = $git::default_owner,) {

  include git

  validate_string($owner)
  validate_string($branch)

  case $ensure {
    'present' : {
      exec { "git-clone-${name}":
        command => "git clone --recursive ${source_url} -b ${branch} ${extra_options} ${destination_dir}",
        path    => '/usr/bin',
        creates => $creates,
        user    => $owner,
      }
    }
    'absent'  : {
      file { $destination_dir:
        ensure  => 'absent',
        recurse => true,
        force   => true,
      }
    }
    default   : {
      fail("git::clone only supports 'present' and 'absent', '${ensure}' is unknown.'")
    }
  }

}