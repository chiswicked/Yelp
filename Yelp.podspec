Pod::Spec.new do |s|
  s.name             = "Yelp"
  s.version          = "0.0.2"
  s.summary          = "Yelp framework"

  s.description      = <<-DESC
                       Yelp framework provides a convenient wrapper around the Yelp API v2.0
                       DESC

  s.homepage         = "https://github.com/chiswicked/Yelp"
  s.license          = 'MIT'
  s.author           = { "chiswicked" => "mr.norbert.metz@googlemail.com" }
  s.source           = { :git => "https://github.com/chiswicked/Yelp.git", :tag => "0.0.2" }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Yelp/**/*'

#  s.dependency 'AFNetworking', '~> 3.0.1'
#  s.dependency 'BDBOAuth1Manager', '~> 2.0'
#  s.dependency 'SwiftyJSON', '~> 2.3.2'
end
