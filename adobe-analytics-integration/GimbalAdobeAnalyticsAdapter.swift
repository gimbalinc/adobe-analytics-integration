
import Foundation

class GimbalAdobeAnalyticsAdapter: NSObject, GMBLPlaceManagerDelegate {
    
    static let sharedInstance = GimbalAdobeAnalyticsAdapter()
    var placeManager: GMBLPlaceManager!
    
    override init() {
        super.init()
        placeManager = GMBLPlaceManager()
        self.placeManager.delegate = self
    }
    
    func startGimbalAndLogEvents(_ gimbalApiKey: String, debugLoggingEnabled:Bool = false) {
        Gimbal.setAPIKey(gimbalApiKey, options: nil)
        Gimbal.start()
        ADBMobile.setDebugLogging(debugLoggingEnabled)
        ADBMobile.collectLifecycleData()
    }
    
    func placeManager(_ manager: GMBLPlaceManager!, didBeginVisit visit: GMBLVisit!) -> Void {
        NSLog("Begin Gimbal Visit for %@", visit.place.description)
        ADBMobile.trackAction("gimbal.place.visit.begin", data:  self.visitData(visit))
    }
    
    func placeManager(_ manager: GMBLPlaceManager!, didEndVisit visit: GMBLVisit!) -> Void {
        NSLog("End Gimbal Visit for %@", visit.place.description)
        ADBMobile.trackAction("gimbal.place.visit.end", data: self.visitData(visit))
    }
    
    func visitData(_ visit: GMBLVisit!) -> Dictionary<String,String> {
        return ["gimbal.place.visit.visitID":visit.visitID,
                "gimbal.place.visit.placeName":visit.place.name,
                "gimbal.place.visit.placeID":visit.place.identifier];
    }
    
}
