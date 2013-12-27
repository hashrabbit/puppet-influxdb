# InfluxDB Puppet Module for Boxen

[![Build Status](https://travis-ci.org/CargoSense/puppet-influxdb.png?branch=master)](https://travis-ci.org/CargoSense/puppet-influxdb)

## Usage

```puppet
include influxdb
```

## Required Puppet Modules

* boxen
* homebrew
* stdlib

### Environment

Once installed, you can access the following variables in your environment, projects, etc:

* BOXEN_INFLUXDB_API_PORT: the configured InfluxDB API port
* BOXEN_INFLUXDB_ADMIN_PORT: the configured InfluxDB admin panel port
* BOXEN_INFLUXDB_RAFT_PORT: the configured InfluxDB raft port

#### Ruby

TODO
