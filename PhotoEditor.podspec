Pod::Spec.new do |s|
    s.name             = 'PhotoEditor'
    s.summary          = 'Photo Editor supports drawing, writing text and adding stickers and emojis.'
    s.version          = '1.0.0'
    s.homepage         = 'https://github.com/Bezlepkin/PhotoEditor'
    s.license          = 'MIT'
    s.author           = { 'Mohamed Hamed' => 'mohamed.hamed.ibrahem@gmail.com' }
    s.source           = { :git => 'https://github.com/Bezlepkin/PhotoEditor.git', :tag => s.version.to_s }
    s.platform     = :ios, '9.0'
    s.source_files = 'Source/**/*.{swift}'
    # s.resources = 'Source/**/*.{png,xib,ttf}'
    s.resource_bundles = { 'PhotoEditor' => ['Resources/*.{png,ttf}'] }
    s.swift_version = '5.0'
  end