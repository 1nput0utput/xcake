require "spec_helper"

module Xcake
  describe Configurable do

    before :each do
      @configuration = Configuration.new(:test)
    end

    context "should set supported devices" do

      it "for iphone only" do
        @configuration.supported_devices = :iphone_only
        expect(@configuration.settings["TARGETED_DEVICE_FAMILY"]).to eq("1")
      end

      it "for ipad only" do
        @configuration.supported_devices = :ipad_only
        expect(@configuration.settings["TARGETED_DEVICE_FAMILY"]).to eq("2")
      end

      it "for universal" do
        @configuration.supported_devices = :universal
        expect(@configuration.settings["TARGETED_DEVICE_FAMILY"]).to eq("1,2")
      end
    end

    context "when accessing preprocessor definitions" do
      it "should return array settings proxy for GCC_PREPROCESSOR_DEFINITIONS" do
        proxy = @configuration.preprocessor_definitions

        expect(proxy.key).to eq("GCC_PREPROCESSOR_DEFINITIONS")
        expect(proxy.settings).to eq(@configuration.settings)
      end
    end
  end
end
