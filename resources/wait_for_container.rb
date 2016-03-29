actions :wait
default_action :wait
attribute :url, :kind_of => String, :required => true
attribute :retries, :kind_of => Integer, :required => true
attribute :sleep, :kind_of => Integer, :required => true

