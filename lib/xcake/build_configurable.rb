module Xcake
  module BuildConfigurable

    #TODO: Implement visitable and figure out how to mix it in with Project and Target

    attr_accessor :all_build_configuration
    attr_accessor :debug_build_configurations
    attr_accessor :release_build_configurations

    def debug_build_configurations
      @build_configurations ||= []
    end

    def release_build_configurations
      @build_configurations ||= []
    end

    def all_build_configurations
      @all_build_configuration ||= BuildConfiguration.new(:all)
    end

    def debug_build_configuration(name, &block)

      build_configuration = self.debug_build_configurations.find do |c|
        c.name == name.to_s
      end

      if build_configuration == nil
        build_configuration = BuildConfiguration.new(name) do |b|
          block.call(b) if block_given?
        end

        self.debug_build_configurations << build_configuration
      end

      build_configuration
    end

    def release_build_configuration(name, &block)

      build_configuration = self.release_build_configurations.find do |c|
        c.name == name.to_s
      end

      if build_configuration == nil
        build_configuration = BuildConfiguration.new(name) do |b|
          block.call(b) if block_given?
        end

        self.release_build_configurations << build_configuration
      end

      build_configuration
    end
  end
end
