# Internal: default values
class influxdb::params {

  case $::operatingsystem {

    'Darwin': {
      include boxen::config

      $basedatadir  = "${boxen::config::datadir}/influxdb"
      $datadir      = "${boxen::config::datadir}/influxdb/data"
      $raftdir      = "${boxen::config::datadir}/influxdb/raft"
      $waldir       = "${boxen::config::datadir}/influxdb/wal"
      $configdir    = "${boxen::config::configdir}/influxdb"
      $logdir       = "${boxen::config::logdir}/influxdb"

      $adminport    = '18083'
      $apiport      = '18086'
      $raftport     = '18090'

      $executable   = "${boxen::config::home}/homebrew/bin/influxdb"

      $package      = 'boxen/brews/influxdb'
      $version      = '0.8.6-boxen'

      $servicename  = 'dev.influxdb'

    }

    default: {
      fail("Unsupported operating system: '${::operatingsystem}'")
    }

  }

  $ensure = present
  $enable = true
}
