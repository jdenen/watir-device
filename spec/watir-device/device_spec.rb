require 'spec_helper'

describe Watir::Device do

  let(:caps){ double("Capabilities") }
  let(:driver){ double("WebDriver") }
  let(:browser){ double("Browser") }
  
  before do
    allow(Selenium::WebDriver::Remote::Capabilities).to receive(:chrome).and_return(caps)
    allow(Selenium::WebDriver).to receive(:for).and_return(driver)
    allow(Watir::Browser).to receive(:new).with(driver).and_return(browser)
  end

  let(:device){ Watir::Device.new "Foo Bar" }

  it "has a browser attribute" do
    expect(device.browser).to eq browser
  end

  it "has a driver attribute" do
    expect(device.driver).to eq driver
  end

  it "passes missing methods to the browser object" do
    expect(browser).to receive(:goto).with("foobar.com")
    device.goto "foobar.com"
  end
    
  describe "#device" do
    it "returns a String" do
      expect(device.device).to be_a String
    end

    it "returns the device name" do
      expect(device.device).to eq "Foo Bar"
    end
  end

  describe "#device_driver" do
    let(:opts){ { "mobileEmulation" => { "deviceName" => "Test" } } }
    
    it "passes device name into Chrome options hash" do
      expect(Selenium::WebDriver::Remote::Capabilities).to receive(:chrome).with("chromeOptions" => opts).and_return(caps)
      device.device_driver "Test"
    end

    it "creates a Selenium::WebDriver instance for Chrome with desired capabilities" do
      allow(Selenium::WebDriver::Remote::Capabilities).to receive(:chrome).with("chromeOptions" => opts).and_return(caps)
      expect(Selenium::WebDriver).to receive(:for).with(:chrome, desired_capabilities: caps)
      device.device_driver "Test"
    end
  end

  describe ".start" do
    before { allow(browser).to receive(:goto) }
    
    it "returns a Watir::Driver instance" do
      expect(Watir::Device.start "foobar.com", "Test").to be_a Watir::Device
    end

    it "navigates the Watir::Device instance to the given URL" do
      expect(browser).to receive(:goto).with("foobar.com")
      Watir::Device.start "foobar.com", "Test"
    end
  end

  describe "#inspect" do
    context "when browser has not been closed" do
      it "returns a String representation of the instance" do
        expect(browser).to receive(:url).and_return('http://www.foo.com')
        inspection = device.inspect
        expect(inspection).to match(/Watir::Device/)
        expect(inspection).to match(/device=Foo Bar/)
        expect(inspection).to match(/url=http:\/\/www.foo.com/)
      end
    end

    context "when browser has been closed" do
      it "returns a String ending in CLOSED" do
        expect(browser).to receive(:url).and_raise(StandardError)
        expect(device.inspect).to match(/CLOSED>/)
      end
    end
  end
end
