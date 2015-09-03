require 'spec_helper'

describe Watir::DeviceError do
  context "when Watir::Device#new is passed an invalid device name" do
    it "raises a DeviceError" do
      expect(Selenium::WebDriver).to receive(:for).and_raise(Selenium::WebDriver::Error::UnknownError)
      expect{ Watir::Device.new "Foo" }.to raise_error(Watir::DeviceError)
    end
  end
end
