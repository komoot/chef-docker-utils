# Logs into the docker registry. Only needs to happen once per instance.

docker_registry "https://#{node['docker']['registry']['url']}" do
  username node['docker']['registry']['username']
  password node['docker']['registry']['password']
  email node['docker']['registry']['email']
end

