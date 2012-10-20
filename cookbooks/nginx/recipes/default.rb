package "build-essential"
package "libpcre3"
package "libpcre3-dev"
package "libssl-dev"

nginx_url = node['nginx']['source']['url']
src_path = "/tmp/nginx-#{node['nginx']['version']}"
src_filepath = "#{src_path}.tar.gz"

remote_file nginx_url do
  source nginx_url
  checksum node['nginx']['source']['checksum']
  path src_filepath
  backup false
end

bash "compile_nginx_source" do
  cwd ::File.dirname(src_filepath)
  code <<-EOH
    tar zxf #{::File.basename(src_filepath)} -C #{::File.dirname(src_filepath)}
    cd nginx-#{node['nginx']['version']} && ./configure --prefix=/opt/nginx-#{node['nginx']['version']}
    make && make install
    ln -s /opt/nginx-#{node['nginx']['version']} /opt/nginx
    ln -s /opt/nginx-#{node['nginx']['version']}/sbin/nginx /usr/bin/nginx
    rm -rf #{src_filepath} #{src_path}
  EOH
end
