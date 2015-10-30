
Pod::Spec.new do |s|

  s.name         = "PonyRouter"
  s.version      = "1.2.0"
  s.summary      = "Application Global Router"

  s.description  = <<-DESC
                   You use PonyRouter response url action in application.
                   DESC

  s.homepage     = "https://github.com/PonyGroup/PonyRouter"

  s.license      = "MIT"

  s.author             = { "ponycui" => "ponycui@me.com" }

  s.platform     = :ios, "5.0"

  s.source       = { :git => "https://github.com/PonyGroup/PonyRouter.git", :tag => "1.2.0" }

  s.source_files  = "PonyRouter/Classes", "PonyRouter/Classes/**", "PonyRouter/Classes/**/**", "PonyRouter/lasses/**/**/**", "PonyRouter/Classes/**/**/**/**"

  s.requires_arc = true

end
