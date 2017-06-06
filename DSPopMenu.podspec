Pod::Spec.new do |s|
  s.name         = "DSPopMenu"
  s.version      = "0.0.3"
  s.summary      = "DSPopMenu是一个弹出菜单"
  s.description  = <<-DESC
                      DSPopMenu是一个弹出菜单DSPopMenu是一个弹出菜单DSPopMenu是一个弹出菜单
                   DESC
  s.homepage     = "https://github.com/suxiaoyao/DSPopMenu"
  s.license      = "MIT"
  s.author       = { "suxiaoyao" => "804290618@qq.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/suxiaoyao/DSPopMenu.git", :tag => "0.0.3" }
  s.source_files = "DSPopMenu/*.{h,m}"
  s.requires_arc = true
  s.frameworks   = 'Foundation', 'UIKit'
  s.dependency 'Masonry'
end
