# Internal: configuration required for influxdb
class influxdb::config(
  $ensure       = $influxdb::params::ensure,

  $basedatadir  = $influxdb::params::basedatadir,
  $datadir      = $influxdb::params::datadir,
  $raftdir      = $influxdb::params::raftdir,
  $waldir       = $influxdb::params::waldir,
  $configdir    = $influxdb::params::configdir,
  $logdir       = $influxdb::params::logdir,

  $adminport    = $influxdb::params::adminport,
  $apiport      = $influxdb::params::apiport,
  $raftport     = $influxdb::params::raftport,

  $executable   = $influxdb::params::executable,

  $package      = $influxdb::params::package,
  $version      = $influxdb::params::version,

  $enable       = $influxdb::params::enable,
  $servicename  = $influxdb::params::servicename
) inherits influxdb::params {

  $dir_ensure = $ensure ? {
    present => directory,
    default => absent,
  }

  if $::operatingsystem == 'Darwin' {
    include boxen::config

    file {
      "${boxen::config::envdir}/influxdb.sh":
        ensure => absent ;

      "/Library/LaunchDaemons/${servicename}.plist":
        content => template('influxdb/darwin/influxdb.plist.erb'),
        group   => 'wheel',
        owner   => 'root' ;
    }

    ->
    boxen::env_script { 'influxdb':
      ensure   => $ensure,
      content  => template('influxdb/darwin/env.sh.erb'),
      priority => 'lower',
    }

  }

  file {
    [
      $basedatadir,
      $configdir,
      $datadir,
      $raftdir,
      $logdir,
    ]:
      ensure  => $dir_ensure;

    "${configdir}/influxdb.conf":
      ensure  => $ensure,
      content => template('influxdb/influxdb.conf.erb') ;
  }

}
