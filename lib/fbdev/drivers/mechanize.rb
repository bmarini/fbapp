require 'mechanize'

module Fbdev
  module Drivers
    class Mechanize < Base
      def list
        login
        page = browser.get("http://www.facebook.com/developers/apps.php")
        page.search("#dev_app_list a").each do |app|
          puts " * " + app.text
        end
      end

      def show(appname)
        login
        page = browser.get("http://www.facebook.com/developers/apps.php")
        link = page.search("#dev_app_list a").find { |a| a.text == appname }

        id  = link.parent["id"].split("_").first
        dl  = page.search("##{id}_info .dev_application_info dl")

        titles, values = dl.search("dt"), dl.search("dd")
        titles = titles.to_a.map { |t| t.text }
        values = values.to_a.map { |v| v.text }

        puts "Settings for #{appname}:"

        settings = Hash[ titles.zip(values) ]
        titles.sort.each do |title|
          puts "* #{title.ljust(19)} : #{settings[title]}"
        end
      end

      def browser
        @browser ||= ::Mechanize.new
      end

      def login
        email, pass = get_or_cache_credentials

        page       = browser.get("http://www.facebook.com")
        form       = page.forms.first
        form.email = email
        form.pass  = pass

        browser.submit(form)
      end

    end
  end
end
