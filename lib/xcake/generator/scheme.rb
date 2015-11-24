require 'xcodeproj'

module Xcake
  module Generator
    class Scheme

      include Visitor

#TODO: BDD this class
      def initialize(project, target)
        @project = project
        @target = target
      end

      def visit_buildconfiguration(configuration)

        scheme_name = "#{@target.name}-#{configuration.name}"

        puts "Generating Scheme #{scheme_name}..."

        scheme = @project.new_scheme
        scheme.add_build_target(@target)
        scheme.name = scheme_name
      end

      def leave_buildconfiguration(configuration)
      end
    end
  end
end
