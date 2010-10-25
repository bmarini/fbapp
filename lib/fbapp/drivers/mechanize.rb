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
        app  = fetch_app(page, appname)

        dl = page.search("##{app.app_id}_info .dev_application_info dl")

        titles, values = dl.search("dt"), dl.search("dd")
        titles = titles.to_a.map { |t| t.text }
        values = values.to_a.map { |v| v.text }

        titles.delete("Sample Code")
        titles.delete("API Key")

        puts "Settings for #{app.name}:"

        settings = Hash[ titles.zip(values) ]
        titles.sort.each do |title|
          puts "* #{title.ljust(19)} : #{settings[title]}"
        end
      end

      # Possible settings to edit:
      # * application_name
      # * connect_url
      # * base_domain
      def edit(appname)
        login
        page = browser.get("http://www.facebook.com/developers/apps.php")
        app  = fetch_app(page, appname)
        page = browser.get("http://www.facebook.com/developers/editapp.php?app_id=#{app.app_id}")
        form = page.form("editapp")
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

      def fetch_app(page, id_or_name)
        apps = fetch_apps(page)
        apps.find { |a| a.name == id_or_name || a.app_id == id_or_name }
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
