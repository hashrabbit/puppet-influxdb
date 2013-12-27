# Internal: default values
class influxdb::params {

  case $::operatingsystem {

    'Darwin': {
      include boxen::config

      $basedatadir  = "${boxen::config::datadir}/influxdb"
      $datadir      = "${boxen::config::datadir}/influxdb/data"
      $raftdir      = "${boxen::config::datadir}/influxdb/raft"
      $configdir    = "${boxen::config::configdir}/influxdb"
      $logdir       = "${boxen::config::logdir}/influxdb"

      $adminport    = '16400'
      $apiport      = '16401'
      $raftport     = '16402'

      $executable   = "${boxen::config::home}/homebrew/bin/influxdb"

      $package      = 'boxen/brews/influxdb'
      $version      = '0.3.2-boxen1'

      $servicename  = 'dev.influxdb'

    }

    default: {
      fail("Unsupported operating system: '${::operatingsystem}'")
    }

  }

  $ensure = present
  $enable = true
}
