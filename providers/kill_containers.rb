action :kill do
  script "kill running #{new_resource.name_pattern} containers" do  
    interpreter "ruby"
    user "root"
    code <<-EOH
    containers = `docker ps`.split("\n").select{|c| c.include? '#{new_resource.name_pattern}'}
    containers.each do |container|
      container_id = container.split("\s")[0]
      `docker stop \#{container_id}`
    end
    containers = `docker ps -a`.split("\n").select{|c| c.include? '#{new_resource.name_pattern}'}
    containers.each do |container|
      container_id = container.split("\s")[0]
      `docker rm \#{container_id}`
    end
    EOH
  end
end
