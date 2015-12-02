module Xcake
  module Generator

    # This generator handles adding nodes
    # to the project and creating a build phase
    # for it.
    #
    class BuildPhase

      include Visitor

      # @return [Project] the xcode project
      #
      attr_accessor :project

      # This should be overidden
      # by subclasses.
      #
      # @param [Node] the node
      #
      # @return [Boolean] boolean for whether this generator can handle the node.
      #
      def self.can_install_node(node)
        true
      end

      # @return [Project] the xcode project
      #
      def initialize(project)
        @project = project
      end

      # Find the group which this node
      # should be added to.
      #
      # This dictates where it shows up
      # in the groups structure.
      #
      # @param [Node] the node
      #
      # @return [PBXGroup] the group
      #
      def group_for_node(node)
        if node.parent
          @project.main_group.find_subpath(node.parent.path, true)
        else
          @project.main_group
        end
      end

      # Adds file reference to the target.
      #
      # This should be overidden in subclasses
      # to add the file reference the correct
      # build phase.
      #
      def add_file_reference_to_target(file_reference, target)
      end

      protected

      def visit_node(node)

        group = group_for_node(node)
        file_reference = group.new_reference(node.path)

        node.targets.each do |t|
           puts "Added to #{t}"
           add_file_reference_to_target(file_reference, t)
        end
      end

      def leave_node(node)
      end

    end
  end
end
