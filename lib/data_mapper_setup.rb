
#   Setting up the environment.
#######################################################################################

env = ENV["RACK_ENV"] || "development"



#   Starting up Datamapper.
#######################################################################################
DataMapper.setup(:default, "postgres://localhost/twitter_chitter_#{env}")
require_relative 'post'
require_relative 'tag'
require_relative 'user'
DataMapper.finalize
