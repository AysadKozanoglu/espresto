require 'spec_helper'

describe 'nrpe::command', :type => :define do

    let(:pre_condition) { 'include nrpe' }

    let :facts do
     { :osfamily     => 'Debian',
       :architecture => 'x86_64',
    }
    end

    let (:title) {'check_users'}
    let :params do
      {
        :command => 'check_users -w 5 -c 10',
        :ensure  => 'present',
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { should contain_file('/etc/nagios/nrpe.d/check_users.cfg') }
end
