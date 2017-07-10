require 'spec_helper'

describe 'nrpe::plugin', :type => :define do

    let(:pre_condition) { 'include nrpe' }

    let :facts do
     { :osfamily     => 'Debian', 
       :architecture => 'x86_64',}
    end

    let (:title) {'check_users'}
    let :params do
      {
        :ensure  => 'present',
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { should contain_file('/usr/lib/nagios/plugins/check_users') }
end
