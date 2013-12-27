# InfluxDB, including service management
#
# Usage:
#
#     include influxdb
class influxdb(
  $ensure       = $influxdb::params::ensure,

  $datadir      =  $influxdb::params::datadir,
  $raftdir      = $influxdb::params::raftdir,
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

  class { 'influxdb::config':
    ensure      => $ensure,

    adminport   => $adminport,
    apiport     => $apiport,
    raftport    => $raftport,
    executable  => $executable,

    servicename => $servicename,
    notify      => Service['influxdb']
  }

  ->
  class { 'influxdb::package':
    ensure  => $ensure,

    package => $package,
    version => $version,
  }

  ->
  class { 'influxdb::service':
    ensure      => $ensure,

    enable      => $enable,
    servicename => $servicename
  }

}
