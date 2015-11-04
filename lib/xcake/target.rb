module Xcake
  class Target

    include BuildConfigurable

    attr_accessor :name
    attr_accessor :type
    attr_accessor :platform
    attr_accessor :deployment_target
    attr_accessor :include_files
    attr_accessor :exclude_files
    attr_accessor :system_frameworks

    def initialize(&block)
      block.call(self) if block_given?
    end

    # def self.common_build_settings(type, platform = nil, deployment_target = nil, target_product_type = nil, language = :objc)
    #     target_product_type = (Constants::PRODUCT_TYPE_UTI.find { |_, v| v == target_product_type } || [target_product_type || :application])[0]
    #     common_settings = Constants::COMMON_BUILD_SETTINGS
    #
    #     # Use intersecting settings for all key sets as base
    #     settings = deep_dup(common_settings[:all])
    #
    #     # Match further common settings by key sets
    #     keys = [type, platform, target_product_type, language].compact
    #     key_combinations = (1..keys.length).flat_map { |n| keys.combination(n).to_a }
    #     key_combinations.each do |key_combination|
    #       settings.merge!(deep_dup(common_settings[key_combination] || {}))
    #     end
    #
    #     if deployment_target
    #       case platform
    #       when :ios then settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
    #       when :osx then settings['MACOSX_DEPLOYMENT_TARGET'] = deployment_target
    #       when :watchos then settings['WATCHOS_DEPLOYMENT_TARGET'] = deployment_target
    #       end
    #     end
    #
    #     settings
    #   end

    # COMMON_BUILD_SETTINGS = {
    #   :all => {
    #     'PRODUCT_NAME'                      => '$(TARGET_NAME)',
    #     'ENABLE_STRICT_OBJC_MSGSEND'        => 'YES',
    #   }.freeze,
    #   [:debug] => {
    #     'MTL_ENABLE_DEBUG_INFO'             => 'YES',
    #   }.freeze,
    #   [:release] => {
    #     'MTL_ENABLE_DEBUG_INFO'             => 'NO',
    #   }.freeze,
    #   [:ios] => {
    #     'SDKROOT'                           => 'iphoneos',
    #   }.freeze,
    #   [:osx] => {
    #     'SDKROOT'                           => 'macosx',
    #   }.freeze,
    #   [:watchos] => {
    #     'SDKROOT'                           => 'watchos',
    #   }.freeze,
    #   [:debug, :osx] => {
    #     # Empty?
    #   }.freeze,
    #   [:release, :osx] => {
    #     'DEBUG_INFORMATION_FORMAT'          => 'dwarf-with-dsym',
    #   }.freeze,
    #   [:debug, :ios] => {
    #     # Empty?
    #   }.freeze,
    #   [:debug, :application, :swift] => {
    #     'SWIFT_OPTIMIZATION_LEVEL'          => '-Onone',
    #     'ENABLE_TESTABILITY'                => 'YES',
    #   }.freeze,
    #   [:debug, :dynamic_library, :swift] => {
    #     'ENABLE_TESTABILITY'                => 'YES',
    #   }.freeze,
    #   [:debug, :framework, :swift] => {
    #     'ENABLE_TESTABILITY'                => 'YES',
    #   }.freeze,
    #   [:debug, :static_library, :swift] => {
    #     'ENABLE_TESTABILITY'                => 'YES',
    #   }.freeze,
    #   [:framework] => {
    #     'VERSION_INFO_PREFIX'               => '',
    #     'DYLIB_COMPATIBILITY_VERSION'       => '1',
    #     'DEFINES_MODULE'                    => 'YES',
    #     'DYLIB_INSTALL_NAME_BASE'           => '@rpath',
    #     'CURRENT_PROJECT_VERSION'           => '1',
    #     'VERSIONING_SYSTEM'                 => 'apple-generic',
    #     'DYLIB_CURRENT_VERSION'             => '1',
    #     'SKIP_INSTALL'                      => 'YES',
    #     'INSTALL_PATH'                      => '$(LOCAL_LIBRARY_DIR)/Frameworks',
    #   }.freeze,
    #   [:ios, :framework] => {
    #     'LD_RUNPATH_SEARCH_PATHS'           => ['$(inherited)', '@executable_path/Frameworks', '@loader_path/Frameworks'],
    #     'CODE_SIGN_IDENTITY[sdk=iphoneos*]' => 'iPhone Developer',
    #     'TARGETED_DEVICE_FAMILY'            => '1,2',
    #   }.freeze,
    #   [:osx, :framework] => {
    #     'LD_RUNPATH_SEARCH_PATHS'           => ['$(inherited)', '@executable_path/../Frameworks', '@loader_path/Frameworks'],
    #     'FRAMEWORK_VERSION'                 => 'A',
    #     'COMBINE_HIDPI_IMAGES'              => 'YES',
    #   }.freeze,
    #   [:framework, :swift] => {
    #     'DEFINES_MODULE'                    => 'YES',
    #   }.freeze,
    #   [:debug, :framework, :swift] => {
    #     'SWIFT_OPTIMIZATION_LEVEL'          => '-Onone',
    #   }.freeze,
    #   [:osx, :static_library] => {
    #     'EXECUTABLE_PREFIX'                 => 'lib',
    #   }.freeze,
    #   [:ios, :static_library] => {
    #     'OTHER_LDFLAGS'                     => '-ObjC',
    #     'SKIP_INSTALL'                      => 'YES',
    #   }.freeze,
    #   [:osx, :dynamic_library] => {
    #     'EXECUTABLE_PREFIX'                 => 'lib',
    #     'DYLIB_COMPATIBILITY_VERSION'       => '1',
    #     'DYLIB_CURRENT_VERSION'             => '1',
    #   }.freeze,
    #   [:application] => {
    #     'ASSETCATALOG_COMPILER_APPICON_NAME' => 'AppIcon',
    #   }.freeze,
    #   [:ios, :application] => {
    #     'CODE_SIGN_IDENTITY[sdk=iphoneos*]' => 'iPhone Developer',
    #     'LD_RUNPATH_SEARCH_PATHS'           => ['$(inherited)', '@executable_path/Frameworks'],
    #   }.freeze,
    #   [:osx, :application] => {
    #     'COMBINE_HIDPI_IMAGES'              => 'YES',
    #     'CODE_SIGN_IDENTITY'                => '-',
    #     'LD_RUNPATH_SEARCH_PATHS'           => ['$(inherited)', '@executable_path/../Frameworks'],
    #   }.freeze,
    #   [:bundle] => {
    #     'PRODUCT_NAME'                      => '$(TARGET_NAME)',
    #     'WRAPPER_EXTENSION'                 => 'bundle',
    #     'SKIP_INSTALL'                      => 'YES',
    #   }.freeze,
    #   [:ios, :bundle] => {
    #     'SDKROOT'                           => 'iphoneos',
    #   }.freeze,
    #   [:osx, :bundle] => {
    #     'COMBINE_HIDPI_IMAGES'              => 'YES',
    #     'SDKROOT'                           => 'macosx',
    #     'INSTALL_PATH'                      => '$(LOCAL_LIBRARY_DIR)/Bundles',
    #   }.freeze,
    # }.freeze
    #

    def system_frameworks
      @system_frameworks ||= default_system_frameworks_for self.platform
    end

    def default_system_frameworks_for(platform)
      (platform == :ios) ? ['Foundation'] : ['Cocoa']
    end
  end
end
