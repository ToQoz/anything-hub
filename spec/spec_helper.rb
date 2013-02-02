root = File.expand_path("../..", __FILE__)
$LOAD_PATH.unshift File.join(root, 'lib')
require 'active_support/core_ext'
require 'anything-hub'

Dir[File.join(root, "spec/support/**/*.rb")].each { |f| require f }
