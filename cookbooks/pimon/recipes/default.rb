#
# Cookbook Name:: pimon
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "ruby1.9.3" do 
  not_if "test -f /usr/bin/ruby"
end

gem_package "pimon" do
  version "0.1.7"
end

directory "/usr/local/lib/pimon/"

template "/usr/local/lib/pimon/pimon.yml" do
  source "pimon.yml.erb"
  group "root"
  owner "root"
  mode 00766
end

service "pimon" do
  supports :restart => true, :start => true, :stop => true, :status => true
  action :nothing
end 

template "/etc/init.d/pimon" do
  source "pimon.erb"
  group "root"
  owner "root"
  mode 00766
  notifies :enable, "service[pimon]"
  notifies :start, "service[pimon]"
end
