Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each {|file| require file }

RSpec.configure do |c|
  c.mock_with :rspec
  # c.formatter = "progress"
  # c.tty = true if defined?(JRUBY_VERSION)
  c.color_enabled = true
end

