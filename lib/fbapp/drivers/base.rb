require 'highline'

module Fbapp
  module Drivers
    class Base

      def get_or_cache_credentials
        credfile = File.expand_path("~/fbapp")
        if File.exist?(credfile)
          email, pass = File.read(credfile).split("\n")
        else
          highline = HighLine.new
          email    = highline.ask("Email:    ")
          pass     = highline.ask("Password: ") { |q| q.echo = false }

          File.open(credfile, "w+") do |f|
            f.puts email
            f.puts pass
          end
        end

        return [email, pass]
      end

    end
  end
end
