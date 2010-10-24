module Fbapp
  autoload :CLI, "fbapp/cli"

  module Drivers
    autoload :Base,      "fbapp/drivers/base"
    autoload :Celerity,  "fbapp/drivers/celerity"
    autoload :Mechanize, "fbapp/drivers/mechanize"
  end
end
