require 'spec_helper_acceptance'

describe 'gluster client' do
  context 'with defaults' do
    it 'idempotently run' do
      pp = <<-EOS

       class { 'gluster':
         repo    => true,
         client  => true,
         server  => false,
         release => '3.9',
       }

      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end

  context 'packages installed' do
    if os[:family] == 'debian'

      describe package('glusterfs-client') do
        it { is_expected.to be_installed }
      end

    elsif os[:family] == 'redhat'

      describe package('glusterfs') do
        it { is_expected.to be_installed }
      end
    end
  end
end
