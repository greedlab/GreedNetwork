Pod::Spec.new do |s|
  s.name         = "GreedNetwork"
  s.version      = "1.0.2"
  s.summary      = "network request for iOS"

  s.description  = %{network request for iOS, based on AFNetworking and GreedJSON }

  s.homepage     = "https://github.com/greedlab/GreedNetwork"

  s.license      = "MIT"

  s.author       = { "Bell" => "bell@greedlab.com" }
   s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/greedlab/GreedNetwork.git", :tag => s.version }

  s.source_files  = "GreedNetwork", "GreedNetwork/*.{h,m}"
   s.framework  = "Foundation"

   s.requires_arc = true

   s.dependency "AFNetworking"
   s.dependency "GreedJSON"
   s.dependency "GreedEmoji"

end
