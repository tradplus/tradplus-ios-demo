# tradplus-ios-demo

TradPlus iOS 广告 SDK 的 **CocoaPods** 集成示例工程。

- CocoaPods 集成示例：本仓库
- Swift Package Manager 集成示例：[TradPlusAdSDK-SPM-Demo](https://github.com/tradplus/TradPlusAdSDK-SPM-Demo)

## 要求

- Xcode 15+
- iOS 14.0+
- CocoaPods

## 快速开始

```bash
cd tradplus-ios-demo
pod install --repo-update
open TradPlusDemo.xcworkspace
```

## 已集成的 Pod（见 `Podfile`）

- `TradPlusAdSDK` 主 SDK 及常用 Adapter
- `TPMediationHelper` 测试与排查工具

## 工程配置

- **Other Linker Flags**: `-ObjC`
- **Deployment Target**: iOS 14.0
- App ID / 广告位 ID 见 `TradPlusDemo/AppDelegate.m`
