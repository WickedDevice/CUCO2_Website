# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Rails.configuration.before_initialize do
  original_verbosity = $VERBOSE
  $VERBOSE = nil
  Rails.configuration.gem 'pundit'
  $VERBOSE = original_verbosity
end