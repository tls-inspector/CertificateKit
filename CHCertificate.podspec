Pod::Spec.new do |s|
    s.name = "CHCertificate"
    s.version = "1.0.2"
    s.summary = "Easily present app related view controllers"
    s.homepage = "https://github.com/certificate-helper/CHCertificate"

    s.license = {
        :type => 'MIT',
        :file => 'LICENSE'
    }
    s.author = {
        'Ian Spence' => 'ian@ecnepsnai.com'
    }
    s.social_media_url = 'https://twitter.com/ecnepsnai'
    s.source = {
        :git => "https://github.com/certificate-helper/CHCertificate.git",
        :tag => s.version.to_s
    }
    s.source_files = 'Classes/*.{h,m}'
    s.public_header_files = 'Classes/*.h'
    s.requires_arc = true
    s.ios.deployment_target = '9.3'

    s.dependency 'OpenSSL-Universal', '1.0.1.20'
end
