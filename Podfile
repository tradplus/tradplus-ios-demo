source 'https://github.com/CocoaPods/Specs.git'
# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'TradPlusDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'TradPlusAdSDK', '15.17.0'
  pod 'TradPlusAdSDK/FacebookAdapter', '15.17.0'
  pod 'FBAudienceNetwork','6.22.0'
  pod 'TradPlusAdSDK/AdMobAdapter', '15.17.0'
  pod 'Google-Mobile-Ads-SDK','13.11.0'
  pod 'TradPlusAdSDK/UnityAdapter', '15.17.0'
  pod 'UnityAds','4.21.0'
  pod 'TradPlusAdSDK/AppLovinAdapter', '15.17.0'
  pod 'AppLovinSDK','13.6.4'
  pod 'TradPlusAdSDK/VungleAdapter', '15.17.0'
  pod 'VungleAds', '7.7.8'
  pod 'TradPlusAdSDK/InMobiAdapter', '15.17.0'
  pod 'InMobiSDK' ,'11.5.0'
  pod 'TradPlusAdSDK/MintegralAdapter', '15.17.0'
  pod 'MintegralAdSDK' ,'8.1.7'
  pod 'MintegralAdSDK/All','8.1.7'
  pod 'TradPlusAdSDK/SigmobAdapter', '15.17.0'
  pod 'SigmobAd-iOS', '5.2.0'
  pod 'TradPlusAdSDK/GDTMobAdapter', '15.17.0'
  pod 'GDTMobSDK', '4.16.11'
  pod 'TradPlusAdSDK/PangleAdapter', '15.17.0'
  pod 'Ads-Global', '8.3.0.9'
  pod 'TradPlusAdSDK/TPCrossAdapter', '15.17.0'
  pod 'TradPlusAdSDK/FyberAdapter', '15.17.0'
  pod 'Fyber_Marketplace_SDK','8.5.0'
  pod 'TradPlusAdSDK/BaiduAdapter', '15.17.0'
  pod 'BaiduMobAdSDK','10.070'
  pod 'TradPlusAdSDK/CSJAdapter', '15.17.0'
  pod 'Ads-CN/BUAdSDK', '7.8.0.7'
  pod 'TradPlusAdSDK/BigoAdapter', '15.17.0'
  pod 'BigoADS','6.1.0'
  pod 'TradPlusAdSDK/TPGoogleIMAAdapter', '15.17.0'
  pod 'GoogleAds-IMA-iOS-SDK','3.32.0'
  pod 'TradPlusAdSDK/TPZMaticooAdapter', '15.17.0'
  pod 'zMaticoo','2.3.0'
  pod 'TradPlusAdSDK/MolocoAdapter', '15.17.0'
  pod 'MolocoSDKiOS','4.11.1'
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
