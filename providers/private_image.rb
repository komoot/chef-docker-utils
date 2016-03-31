action :pull do

  # Get image from private repository. Login using the docker-utils::registry recipe first.
  docker_image "#{node['docker']['registry']['url']}/#{new_resource.name}" do
    action :pull
    tag new_resource.tag
    force true
    read_timeout 300
  end

  # Make the repo and tag available to subsequent docker_container resource.
  container_r = run_context.resource_collection.find(:docker_container => new_resource.name)
  if container_r 
    repo = "#{node['docker']['registry']['url']}/#{new_resource.name}"
    tag = new_resource.tag

    Chef::Log.debug("Setting docker_container resource 'repo' attribute to '#{repo}'")
    Chef::Log.debug("Setting docker_container resource 'tag' attribute to '#{tag}'")

    container_r.repo repo
    container_r.tag tag
  else
    Chef::Log.error("Could not find the resource docker_container[#{new_resource.name}]!")
  end

end
