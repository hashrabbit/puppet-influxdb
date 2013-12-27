require 'spec_helper'

describe 'influxdb' do
  let!(:facts) { default_test_facts }
  it do
    should contain_class("influxdb")
  end
end
