# Gimbal Adobe Analytics Integration #

This sample project shows how Gimbal can be integrated with Adobe Analytics.

In this integration information regarding Place events are sent to Adobe Analytics. You can than use this information from within Adobe's analytic tools.

## Setup ##

Please refer to the [hello-gimbal-ios](https://github.com/gimbalinc/hello-gimbal-ios) for generic Gimbal setup and dependencies. We use [CocoaPods](https://cocoapods.org/?q=gimbal) to install our SDK.

```ruby
pod 'Gimbal'
```

You will need to enter your Gimbal API Key into the AppDelegate.swift file.

You will need to add your Adobe libraries and configuration into the project. This includes the following:

* ADBMobileConfig.json
* ADBMobile.h
* ADBMobileLibrary.a

And link the ADBMobileLibrary.a to the application target.

For more detailed information see the [Adobe Documentation](https://marketing.adobe.com/resources/help/en_US/mobile/ios/dev_qs.html)

## GimbalAdobeAnalyticsAdapter ##

To make integration easier we have created a helper class GimbalAdobeAnalyticsAdapter that exposes a simple method

```swift
GimbalAdobeAnalyticsAdapter.sharedInstance.startGimbalAndLogEvents("PUT_YOUR_GIMBAL_API_KEY_HERE")
```

By invoking this method with the appropriate Gimbal API key both frameworks are initialized and place events are monitored and sent to Adobe.

The code for GimbalAdobeAnalyticsAdapter shows how Place events are sent to Adobe.

```swift

import Foundation

class GimbalAdobeAnalyticsAdapter: NSObject, GMBLPlaceManagerDelegate {
    
    static let sharedInstance = GimbalAdobeAnalyticsAdapter()
    var placeManager: GMBLPlaceManager!
    
    override init() {
        super.init()
        placeManager = GMBLPlaceManager()
        self.placeManager.delegate = self
    }
    
    func startGimbalAndLogEvents(gimbalApiKey: String, debugLoggingEnabled:Bool = false) {
        Gimbal.setAPIKey(gimbalApiKey, options: nil)
        Gimbal.start()
        ADBMobile.setDebugLogging(debugLoggingEnabled)
        ADBMobile.collectLifecycleData()
    }
    
    func placeManager(manager: GMBLPlaceManager!, didBeginVisit visit: GMBLVisit!) -> Void {
        NSLog("Begin Gimbal Visit for %@", visit.place.description)
        ADBMobile.trackAction("gimbal.place.visit.begin", data:  self.visitData(visit))
    }
    
    func placeManager(manager: GMBLPlaceManager!, didEndVisit visit: GMBLVisit!) -> Void {
        NSLog("End Gimbal Visit for %@", visit.place.description)
        ADBMobile.trackAction("gimbal.place.visit.end", data: self.visitData(visit))
    }
    
    func visitData(visit: GMBLVisit!) -> Dictionary<String,String> {
        return ["gimbal.place.visit.visitID":visit.visitID,
                "gimbal.place.visit.placeName":visit.place.name,
                "gimbal.place.visit.placeID":visit.place.identifier];
    }
    
}

```
