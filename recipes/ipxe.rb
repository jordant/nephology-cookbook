include_recipe 'build-essential'

%w{ genisoimage liblzma-dev }.each { |pkg| package pkg }

git '/opt/ipxe' do
  repository 'git://git.ipxe.org/ipxe.git'
  reference 'HEAD'
  action :sync
end

template '/opt/ipxe/nephology.ipxe' do
  source 'nephology.ipxe.erb'
end

bash 'build ipxe image' do
  cwd '/opt/ipxe/src'
  code <<-EOH
    make EMBED=/opt/ipxe/nephology.ipxe
  EOH
end