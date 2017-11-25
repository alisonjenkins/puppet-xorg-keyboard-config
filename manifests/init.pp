# Class: xorg_keyboard_init
# ===========================
#
# Full description of class xorg_keyboard_config here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'xorg_keyboard_config':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class xorg_keyboard_config (
  String $numlock_default = 'on',
  String $capslock_mode = '',
  String $model = 'pc104',
  String $layout = 'gb',
  String $variant = ',dvorak',
  String $options = '',
)
{
  if $numlock_default == 'on' {
    ini_setting {'enable numlock on boot':
      ensure  => present,
      path    => '/etc/sddm.conf',
      section => 'General',
      setting => 'Numlock',
      value   => 'on'
    }
  }
  else
  {
    ini_setting {'disable numlock on boot':
      ensure  => present,
      path    => '/etc/sddm.conf',
      section => 'General',
      setting => 'Numlock',
      value   => 'off'
    }
  }

  $xkb_options = "${options}"

	file {'xorg keyboard config file':
    ensure  => present,
    path    => '/etc/X11/xorg.conf.d/00-keyboard.conf',
    content => template('xorg_keyboard_config/keyboard.erb'),
    require => Package['xorg-server']
  }
}
