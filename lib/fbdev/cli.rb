require "thor"

module Fbdev
  class CLI < Thor
    desc "list", "List your facebook apps"
    def list
      driver.list
    end

    desc "show", "Show app settings"
    def show(app)
      driver.show(app)
    end

    protected
    def driver
      @driver ||= Drivers::Mechanize.new
    end
  end
end