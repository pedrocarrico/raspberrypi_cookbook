package "build-essential"

redis_url = node['redis']['source']['url']
src_path = "/tmp/redis-#{node['redis']['version']}"
src_filepath = "#{src_path}.tar.gz"

remote_file redis_url do
  source redis_url
  checksum node['redis']['source']['checksum']
  path src_filepath
  backup false
end

bash "compile_redis_source" do
  cwd ::File.dirname(src_filepath)
  code <<-EOH
    tar zxf #{::File.basename(src_filepath)} -C #{::File.dirname(src_filepath)}
    cd redis-#{node['redis']['version']}
    make
    cp -r ../redis-#{node['redis']['version']} /opt/redis-#{node['redis']['version']}
    ln -s /opt/redis-#{node['redis']['version']} /opt/redis
    ln -s /opt/redis-#{node['redis']['version']}/src/redis-server /usr/bin/redis-server
    ln -s /opt/redis-#{node['redis']['version']}/src/redis-cli /usr/bin/redis-cli
    #rm -rf #{src_filepath} #{src_path}
  EOH
end
