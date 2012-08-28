#!/usr/bin/env rspec

require 'spec_helper'

describe 'mysql' do
  it { should contain_class 'mysql' }
end
