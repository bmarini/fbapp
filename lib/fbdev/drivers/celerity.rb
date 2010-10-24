require "celerity"

module Fbdev
  module Drivers
    class Celerity < Base
      def list
        login
        browser.goto("http://www.facebook.com/developers/apps.php")
        puts browser.div(:id, "dev_app_list").text
      end

      def show(app)
        login
        browser.goto("http://www.facebook.com/developers/apps.php")
        lnk = browser.div(:id, "dev_app_list").links.find { |l| l.text == app }
        lnk.click

        id  = lnk.parent.id.split("_").first
        dl  = browser.div(:id, "#{id}_info").div(:class, "dev_application_info").dl

        titles, values = dl.dts, dl.dds
        titles.zip(values).each do |k, v|
          puts "#{k.text.ljust(19)} : #{v.text}"
        end
      end

      def browser
        @browser ||= ::Celerity::Browser.new
      end

      def login
        email, pass = get_or_cache_credentials
        browser.goto("http://www.facebook.com")
        browser.text_field(:name, "email").value = email
        browser.text_field(:name, "pass").value = pass
        browser.button(:value, "Login").click
      end

    end
  end
end