module Xcake
  module Configurable

    attr_accessor :all_configuration
    attr_accessor :debug_configurations
    attr_accessor :release_configurations

    def flatten_configurations
      all_settings = all_configurations.settings
      flattened_configurations = []

      debug_configurations.each do |b|
        b.settings = default_debug_settings.merge!(all_settings).merge!(b.settings)
        flattened_configurations << b
      end

      release_configurations.each do |b|
        b.settings = default_release_settings.merge!(all_settings).merge!(b.settings)
        flattened_configurations << b
      end

      flattened_configurations
    end

    def debug_configurations
      @debug_configurations ||= []
    end

    def release_configurations
      @release_configurations ||= []
    end

    def all_configurations
      @all_configuration ||= Configuration.new(:all)
    end

    def debug_configuration(name, &block)

      configuration = debug_configurations.find do |c|
        c.name == name.to_s
      end

      if configuration == nil
        configuration = Configuration.new(name) do |b|
          block.call(b) if block_given?
        end

        debug_configurations << configuration
      end

      configuration
    end

    def release_configuration(name, &block)

      configuration = release_configurations.find do |c|
        c.name == name.to_s
      end

      if configuration == nil
        configuration = Configuration.new(name) do |b|
          block.call(b) if block_given?
        end

        release_configurations << configuration
      end

      configuration
    end
  end
end
