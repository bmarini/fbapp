require 'highline'

module Fbapp
  module Drivers
    class Base

      def get_or_cache_credentials
        credfile_exists? ? creds_from_file : creds_from_ui
      end

      protected

      def creds_from_file
        File.read(credfile).split("\n")
      end

      def creds_from_ui
        highline = HighLine.new
        email    = highline.ask("Email:    ")
        pass     = highline.ask("Password: ") { |q| q.echo = false }

        File.open(credfile, "w+") do |f|
          f.puts email
          f.puts pass
        end

        return [ email, pass ]
      end

      def credfile_exists?
        File.exist?(credfile)
      end

      def credfile
        File.expand_path("~/.fbapp")
      end

    end
  end
end
