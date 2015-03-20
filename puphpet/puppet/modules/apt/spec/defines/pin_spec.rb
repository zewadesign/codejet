require 'spec_helper'
describe 'apt::pin', :type => :define do
  let(:facts) { { :lsbdistid => 'Debian' } }
  let(:title) { 'my_pin' }

  let :default_params do
    {
      :ensure   => 'present',
      :order    => '',
      :packages => '*',
      :priority => '0',
      :release  => nil
    }
  end

  [
    { :params  => {},
      :content => "# my_pin\nExplanation: : my_pin\nPackage: *\nPin: release a=my_pin\nPin-Priority: 0\n"
    },
    {
      :params => {
        :priority => '1',
        :origin   => 'ftp.de.debian.org'
      },
      :content => "# my_pin\nExplanation: : my_pin\nPackage: *\nPin: origin ftp.de.debian.org\nPin-Priority: 1\n"
    },
  ].each do |param_set|
    describe "when #{param_set == {} ? "using default" : "specifying"} define parameters" do
      let :param_hash do
        default_params.merge(param_set[:params])
      end

      let :params do
        param_set[:params]
      end

      it { should contain_class("apt::params") }

      it { should contain_file("#{title}.pref").with({
          'ensure'  => param_hash[:ensure],
          'path'    => "/etc/apt/preferences.d/#{param_hash[:order] == '' ? "" : "#{param_hash[:order]}-"}#{title}.pref",
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
          'content' => param_set[:content],
        })
      }
    end
  end
end
