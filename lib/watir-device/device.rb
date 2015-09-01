require 'watir-webdriver'

module Watir
  class Device
    attr_reader :device_name, :driver, :browser
    
    class << self
      def start url, device_name, *args
        new(device_name, *args).tap { |dev| dev.goto url }
      end
    end

    def initialize device_name, *args
      @driver = device_driver(device_name)
      @device_name = device_name
      @browser = Watir::Browser.new driver
    end

    def device
      device_name
    end

    def device_driver name
      opts = {
        "mobileEmulation" => {
          "deviceName" => name
        }
      }
      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => opts)
      Selenium::WebDriver.for(:chrome, desired_capabilities: capabilities)
    end

    private
    
    def method_missing mthd, *args
      browser.send(mthd, *args)
    end
  end
end
