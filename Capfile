# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'
require 'capistrano/passenger'
require "capistrano-resque"
require 'capistrano/rvm'
require 'capistrano/rails'

require 'bugsnag/capistrano'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

set :bugsnag_api_key, "5064645706772365c1ab89cd8e5a695d" 
