
Pod::Spec.new do |s|

  s.name         = "PonyRouter"
  s.version      = "0.0.1"
  s.summary      = "A short description of PonyRouter."

  s.description  = <<-DESC
                   A longer description of PonyRouter in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "http://EXAMPLE/PonyRouter"

  s.license      = "MIT"

  s.author             = { "ponycui" => "" }

  s.platform     = :ios, "5.0"

  s.source       = { :git => "https://github.com/PonyGroup/PonyRouter.git" }

  s.source_files  = "Classes", "Classes/**", "Classes/**/**", "Classes/**/**/**", "Classes/**/**/**/**"

  s.requires_arc = true

end
