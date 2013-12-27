# Internal: manage the influxdb package
class influxdb::package(
  $ensure  = $influxdb::params::ensure,
  $package = $influxdb::params::package,
  $version = $influxdb::params::version,
) inherits influxdb::params {

  $real_ensure = $ensure ? {
    present => $version,
    default => absent,
  }

  package { $package:
    ensure => $real_ensure,
  }

  if $::operatingsystem == 'Darwin' {
    include boxen::config

    homebrew::formula { 'influxdb': }

    ->
    Package[$package]

    ->
    file {
      "${boxen::config::homebrewdir}/etc/influxdb.conf":
        ensure => absent ;

      "${boxen::config::homebrewdir}/var/influxdb":
        ensure  => absent,
        force   => true,
        recurse => true,
    }
  }

}
