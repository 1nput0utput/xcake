module Xcake
  class ProjectStructureResolver

    include Visitor

    def visit_cakefile(cakefile)

      cakefile.debug_build_configuration :debug if cakefile.debug_build_configurations.count == 0
      cakefile.release_build_configuration :release if cakefile.release_build_configurations.count == 0
    end

    def leave_cakefile(cakefile)
    end

    def visit_target(target)
    end

    def leave_target(target)
    end
  end
end
