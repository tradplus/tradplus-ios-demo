source 'https://github.com/CocoaPods/Specs.git'
# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'TradPlusDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'TradPlusAdSDK', '15.18.0'
  pod 'TradPlusAdSDK/FacebookAdapter', '15.18.0'
  pod 'FBAudienceNetwork','6.22.1'
  pod 'TradPlusAdSDK/AdMobAdapter', '15.18.0'
  pod 'Google-Mobile-Ads-SDK','13.11.0'
  pod 'TradPlusAdSDK/UnityAdapter', '15.18.0'
  pod 'UnityAds','4.21.0'
  pod 'TradPlusAdSDK/AppLovinAdapter', '15.18.0'
  pod 'AppLovinSDK','13.6.4'
  pod 'TradPlusAdSDK/VungleAdapter', '15.18.0'
  pod 'VungleAds', '7.7.8'
  pod 'TradPlusAdSDK/IronSourceAdapter', '15.18.0'
  pod 'IronSourceSDK','9.7.0.0'
  pod 'TradPlusAdSDK/InMobiAdapter', '15.18.0'
  pod 'InMobiSDK' ,'11.5.0'
  pod 'TradPlusAdSDK/MintegralAdapter', '15.18.0'
  pod 'MintegralAdSDK' ,'8.1.8'
  pod 'MintegralAdSDK/All','8.1.8'
  pod 'TradPlusAdSDK/SigmobAdapter', '15.18.0'
  pod 'SigmobAd-iOS', '5.2.0'
  pod 'TradPlusAdSDK/GDTMobAdapter', '15.18.0'
  pod 'GDTMobSDK', '4.16.11'
  pod 'TradPlusAdSDK/PangleAdapter', '15.18.0'
  pod 'Ads-Global', '8.4.0.5'
  pod 'TradPlusAdSDK/MyTargetAdapter', '15.18.0'
  pod 'myTargetSDK', '5.47.0'
  pod 'TradPlusAdSDK/StartAppAdapter',  '15.18.0'
  pod 'StartAppSDK','4.15.0'
  pod 'TradPlusAdSDK/TPCrossAdapter', '15.18.0'
  pod 'TradPlusAdSDK/FyberAdapter', '15.18.0'
  pod 'Fyber_Marketplace_SDK','8.5.0'
  pod 'TradPlusAdSDK/OguryAdapter', '15.18.0'
  pod 'OgurySdk', '5.3.1'
  pod 'TradPlusAdSDK/BaiduAdapter', '15.18.0'
  pod 'BaiduMobAdSDK','10.070'
  pod 'TradPlusAdSDK/VerveAdapter', '15.18.0'
  pod 'HyBid','3.9.3'
  pod 'TradPlusAdSDK/CSJAdapter', '15.18.0'
  pod 'Ads-CN/BUAdSDK', '7.8.0.7'
  pod 'TradPlusAdSDK/BigoAdapter', '15.18.0'
  pod 'BigoADS','6.1.0'
  pod 'TradPlusAdSDK/TPGoogleIMAAdapter', '15.18.0'
  pod 'GoogleAds-IMA-iOS-SDK','3.33.0'
  pod 'TradPlusAdSDK/TPZMaticooAdapter', '15.18.0'
  pod 'zMaticoo','2.3.2'
  pod 'TradPlusAdSDK/TaurusXAdapter', '15.18.0'
  pod 'TaurusxAdsSDK','1.20.0'
  pod 'TradPlusAdSDK/MolocoAdapter', '15.18.0'
  pod 'MolocoSDKiOS','4.12.0'
  pod 'TradPlusAdSDK/MagniteAdapter', '15.18.0'
  pod 'MagniteSDK','1.0.5'
##测试工具
pod "TPMediationHelper",'1.4.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end
