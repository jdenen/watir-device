require 'watir-webdriver'

module Watir

  #
  # Automate Chrome in mobile emulation mode. Devices availabe for emulation are available in the 
  # Dev Tool preferences, including "Apple iPhone 6 Plus", "Samsung Galaxy Note 3", "Google Nexus 10", etc.
  #
  # @author Johnson Denen
  #
  class Device
    attr_reader :device_name, :driver, :browser
    
    class << self
      
      #
      # Spin up an instance and navigate to a URL.
      #
      # @example Open iPhone 6+ to google.com
      #   Watir::Device.start "www.google.com", "Apple iPhone 6 Plus"
      #
      # @param url [String] URL to visit
      # @param device_name [String] device to emulate
      # @return [Watir::Device]
      #
      def start url, device_name, *args
        new(device_name, *args).tap { |dev| dev.goto url }
      end
    end

    #
    # Emulate a device browser with Chrome's mobile emulation tool.
    #
    # @param device_name [String] device to emulate
    # @return [Watir::Device]
    #
    def initialize device_name, *args
      begin
        @driver = device_driver(device_name)
      rescue Selenium::WebDriver::Error::UnknownError => e
        raise DeviceError, "Invalid device name: '#{device_name}'"
      end
      @device_name = device_name
      @browser = Watir::Browser.new driver
    end

    #
    # Get the emulated device's name.
    #
    # @return [String]
    #
    def device
      device_name
    end

    #
    # Closed instances will return string ending in CLOSED.
    #
    # @return [String]
    # @see Object#inspect
    #
    def inspect
      '<#%s:0x%x device=%s url=%s>' % [self.class, hash*2, device, browser.url] rescue '<#%s:0x%x device=%s CLOSED>' % [self.class, hash*2, device]
    end

    # Build a WebDriver to emulate the device.
    # @api private    
    def device_driver name
      opts = {
        "mobileEmulation" => {
          "deviceName" => name
        }
      }
      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => opts)
      Selenium::WebDriver.for(:chrome, desired_capabilities: capabilities)
    end

    # Undefined methods are passed to Watir::Browser.
    # @see https://github.com/watir/watir-webdriver/blob/master/lib/watir-webdriver/browser.rb Watir::Browser
    # @api private    
    def method_missing mthd, *args
      browser.send(mthd, *args)
    end
  end
end
