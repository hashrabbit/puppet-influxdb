# Internal: management of the influxdb service
class influxdb::service(
  $ensure      = $influxdb::params::ensure,

  $servicename = $influxdb::params::servicename,
  $enable      = $influxdb::params::enable,
) inherits influxdb::params {

  $real_ensure = $ensure ? {
    present => running,
    default => stopped,
  }

  service { $servicename:
    ensure => $real_ensure,
    enable => $enable,
    alias  => 'influxdb',
  }

  if $::operatingsystem == 'Darwin' {

    service { 'com.boxen.influxdb':
      ensure => stopped,
      enable => false,
    }

    ->
    Service[$servicename]
  }

}
