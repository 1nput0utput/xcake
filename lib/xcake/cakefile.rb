module Xcake
  class Cakefile

    attr_accessor :project_name
    attr_accessor :targets

    def initialize(name="Project", &block)
      self.project_name = name
      self.targets = []

      block.call(self) if block_given?
    end

    def target(name)
      self.targets << Target.new(name)
    end
  end
end
