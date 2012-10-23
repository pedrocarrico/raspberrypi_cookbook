require 'chef/util/file_edit'

ruby_block "put hostname into /etc/hosts" do
  hosts_file = File.read("/etc/hosts")
  block do
    hosts = Chef::Util::FileEdit.new('/etc/hosts')
    hosts.search_file_replace(node['host_name']['previous'], node['host_name']['new'])
    hosts.write_file
  end
  only_if { hosts_file.include?(node['host_name']['previous']) }

  hostname_file = File.read("/etc/hostname")
  block do
    hosts = Chef::Util::FileEdit.new('/etc/hostname')
    hosts.search_file_replace(node['host_name']['previous'], node['host_name']['new'])
    hosts.write_file
  end
  only_if { hostname_file.include?(node['host_name']['previous']) }
end

bash "change raspberry pi hostname" do
  code <<-EOH
    /etc/init.d/hostname.sh
  EOH
end
