module Fbdev
  module Drivers
    class Base

      def get_or_cache_credentials
        credfile = File.expand_path("~/fbdev")
        if File.exist?(credfile)
          email, pass = File.read(credfile).split("\n")
        else
          email = ask("Email:")
          pass  = ask("Password:")

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
