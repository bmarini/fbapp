require 'mechanize'

module Fbapp
  module Drivers
    class Mechanize < Base

      App = Struct.new(:app_id, :name)

      def list
        login
        page = browser.get("http://www.facebook.com/developers/apps.php")
        apps = fetch_apps(page)

        apps.each do |app|
          puts " * %s %s" % [app.app_id, app.name]
        end
      end

      def show(appname)
        login
        page = browser.get("http://www.facebook.com/developers/apps.php")

        id = begin
          apps = fetch_apps(page)
          apps.find { |a| a.name == appname || a.app_id == appname }.app_id
        end

        dl = page.search("##{id}_info .dev_application_info dl")

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

      # Assumes page is http://www.facebook.com/developers/apps.php
      def fetch_apps(page)
        page.search("#dev_app_list a").collect do |a|
          id   = a.parent["id"].split("_").first
          name = a.text

          App.new(id, name)
        end
      end
    end
  end
end
