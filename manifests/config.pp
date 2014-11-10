# = Define a git config
#
# This sets configuration paramenters for github
# It can be used to set system wide configs or user specific configs
#
# == Parameters:
#
# [*section*]
#   The section of the config
# [*key*]
#   The name of the config
# [*value*]
#   The value for the config
# [*user*]
#   The user to save the config (defaults to system config)
#
# == Examples:
#
# - Minimal setup for system config
# github::config { 'color.status' :          
#   value => 'auto' 
# }
#
# - Full setup for user specific config
# github::config { 'color-status' :
#   section => 'color',
#   key     => 'status',
#   value   => 'auto',
#   user    => $::id
# }

define git::config(
   $section = '', 
   $key     = '', 
   $value, 
   $user    = ''
) {

   include git

   if empty($user) {
      $real_command = "git config --system"
   } 
   else {
      validate_string($user)
      $real_command = "sudo -u ${user} git config --global"
   }

   if empty($section) and empty($key) {
      validate_re($name, '^\w+\.\w+$')
      $real_section_key = $name
   } 
   else {
      $real_section_key = "${section}.${key}" 
   }

   exec { $real_section_key:
      command => "${real_command} ${real_section_key} \"$value\"",
      onlyif  => "test \"`${real_command} ${real_section_key}`\" = \"${value}\"",
      require => Package['git'],
   }
}