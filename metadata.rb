name             'docker-utils'
maintainer       'komoot GmbH'
maintainer_email 'johannes@komoot.de'
license          'All rights reserved'
description      'Docker-related utilities'
long_description <<-EOH
Some utilities around the docker cookbook:

* pulling images from a private repo and starting them
* waiting for a container to start
EOH
supports         'ubuntu', '>= 14.04'
version          '1.0.1'

depends 'docker', '~> 2.5.8'
