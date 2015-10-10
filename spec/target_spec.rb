require 'spec_helper'

module Xcake
  describe Target do

    it "should set the name when created" do
      name = "Target"
      target = Target.new(name)

      expect(target.name).to eq(name)
    end
  end
end
