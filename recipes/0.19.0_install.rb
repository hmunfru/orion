include_recipe "orion::mongod2"
include_recipe "orion::fiware_repo"

package node[:oriondbcluster][:package_name] do
  action :install
  options "--nogpgcheck"
end




# context init
template "/opt/contextini.sh" do
    action :create
    source "contextbroker.init.erb"
    group "root"
    owner "root"
    mode "777"
end

bash "install_something" do
  user "root"
  code <<-EOH
    ./opt/contextini.sh > /opt/contextbroker.out
  EOH
end

bash "start_context_broker" do
  user "root"
  code <<-EOH
    /etc/init.d/contextBroker start
  EOH
end

