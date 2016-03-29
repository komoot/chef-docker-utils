# Waits for a docker container to start.
#
# Exits with code 0 if the given url responds with 200 OK.
# Exits with code 1 if either the maximum retries are reached or the container exited with a code != 0
#

action :wait do
  
  bash "Waiting for container #{new_resource.name} to be available at #{new_resource.url}" do
    code <<-EOF

      container_name=#{new_resource.name}
      url=#{new_resource.url}
      retry=#{new_resource.retries}
      sleep_time=#{new_resource.sleep}

      echo "waiting for $container_name, checking $url"
      until curl -f -sS "$url" 2> /dev/null; do
        if [ $(( retry-- )) -eq 0 ]; then
          echo "maximum retries exceeded. $container_name didn't start"
          docker logs $container_name
          exit 1
        fi
        echo -n "."

        sleep $sleep_time

        # check if still running...
        code=$(docker inspect -f '{{.State.ExitCode}}' $container_name)
        if [ "$code" != "0" ]; then
          echo -e "\ndocker container '$container_name' exited with code $code:"
          docker logs $container_name
          exit 1
        fi
      done

      EOF
  end

  Chef::Log.info("docker application #{new_resource.name} is running")
end
