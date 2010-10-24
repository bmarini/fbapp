module Fbdev
  autoload :CLI,     "fbdev/cli"

  module Drivers
    autoload :Base,    "fbdev/drivers/base"
    autoload :Celerity, "fbdev/drivers/celerity"
    autoload :Mechanize, "fbdev/drivers/mechanize"
  end
end
