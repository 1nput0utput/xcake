module Xcake
  module Generator
    class CopyResourcesBuildPhase < BuildPhase

      def self.can_install_node(node)
        File.directory?(node.path) == false &&
        [".h", ".hpp"].include?(File.extname(node.path)) == false
      end

      def add_file_reference_to_target(file_reference, target)
        target.resources_build_phase.add_file_reference(file_reference)
      end
    end
  end
end
