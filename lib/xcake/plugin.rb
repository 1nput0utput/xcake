module Xcake
  module Plugin
    def self.load_plugins
      Dir[plugins_location].each {|file| require file }
      descendants
    end

    def self.plugins_location
    end
  end
end
