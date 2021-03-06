require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('ntp'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe file('/etc/ntp.conf') do
  it { should be_file }
  its(:content) { should match /server 0.pool.ntp.org prefer/ }
  its(:content) { should match /server 1.pool.ntp.org/ }
end

describe "Ntp Daemon" do
  it "has a running service of ntpd" do
    expect(service("ntpd")).to be_running
  end
end
