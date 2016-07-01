require 'tsort'

module Xcake
  class DependencyProvider

    include TSort

    alias tsort_each_node each

    attr_accessor :repository

    def initialize(repository)
      @repository = repository
    end

    def name_for(dependency)
      dependency
    end

    def search_for(dependency)
      @repository.select do |g|
        g == dependency
      end
    end

    def dependencies_for(specification)
      specification.dependencies
    end
  end
end
