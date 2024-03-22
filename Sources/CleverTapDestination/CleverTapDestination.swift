//
//  CleverTapDestination.swift
//
//

import Foundation
import Sovran
import Journify
import CleverTapSDK

public class CleverTapDestination: DestinationPlugin {
    public var key: String = "CleverTap"
    public var timeline = Timeline()
    public var type = PluginType.destination
    public weak var analytics: Journify? = nil
    
    let cleverTap: CleverTap
    
    public init(accountID: String, token: String, region: String? = nil, proxyDomain: String? = nil, spikyProxyDomain: String? = nil) {
        if let proxyDomain = proxyDomain, let spikyProxyDomain = spikyProxyDomain {
            CleverTap.setCredentialsWithAccountID(accountID, token: token, proxyDomain: proxyDomain, spikyProxyDomain: spikyProxyDomain)
        } else if let region = region {
            CleverTap.setCredentialsWithAccountID(accountID, token: token, region: region)
        } else {
            CleverTap.setCredentialsWithAccountID(accountID, andToken: token)
        }
        let libName = "Journify-iOS"
        CleverTap.sharedInstance()?.setLibrary(libName)
        CleverTap.sharedInstance()?.setCustomSdkVersion(libName, version: 1)
        CleverTap.sharedInstance()?.notifyApplicationLaunched(withOptions: nil)
        cleverTap = CleverTap.sharedInstance()!
    }
    
    public func identify(event: IdentifyEvent) -> IdentifyEvent? {
        guard let traits = event.traits else { return event}
        var profile: [String: Any] = traits.dictionaryValue ?? [:]
        if let userId = event.userId {
            profile["Identity"] = userId
        }
        if let email = profile["email"] as? String {
            profile["Email"] = email
        }
        if let name = profile["firstname"] as? String {
            profile["Name"] = name
        }
        if let phone = profile["phone"] as? String {
            profile["Phone"] = phone
        }
        if let gender = profile["gender"] as? String {
            profile["Gender"] = gender.lowercased() == "m" ? "M" : "F"
        }
        if let birthday = profile["birthday"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            if let date = dateFormatter.date(from: birthday) {
                profile["DOB"] = date
            }
        } else if let birthday = profile["birthday"] as? Date {
            profile["DOB"] = birthday
        }
        // Remove nested dictionaries from profile
        profile = profile.filter { !($0.value is NSDictionary) }
        
        cleverTap.onUserLogin(profile)
        return event
    }
    
    public func track(event: TrackEvent) -> TrackEvent? {
        let eventName = event.event
        if eventName == "Order Completed" {
            self.handleOrderCompleted(event: event)
        } else {
            cleverTap.recordEvent(eventName, withProps: event.properties?.dictionaryValue ?? [:])
        }
        return event
    }
    
    public func screen(event: ScreenEvent) -> ScreenEvent? {
        guard let screenName = event.name else { return event }
        cleverTap.recordScreenView(screenName)
        return event
    }
    
    func handleOrderCompleted(event: TrackEvent) {
        var details = [String: Any]()
        var items = [Any]()
        
        if let segmentProps = event.properties?.dictionaryValue as? [String: Any] {
            for (key, value) in segmentProps {
                if key == "products", let products = value as? [Any], !products.isEmpty {
                    items = products
                } else if value is NSDictionary || value is NSArray {
                    continue
                } else if key == "order_id" || key == "total" {
                    details["Charged ID"] = value
                    details[key] = value
                } else {
                    details[key] = value
                }
            }
        }
        CleverTap.sharedInstance()?.recordChargedEvent(withDetails: details, andItems: items)
    }
}

extension CleverTapDestination: RemoteNotifications {
    public func registeredForRemoteNotifications(deviceToken: Data) {
        cleverTap.setPushToken(deviceToken)
    }
        
    public func receivedRemoteNotification(userInfo: [AnyHashable : Any]) {
        cleverTap.handleNotification(withData: userInfo)
    }
}
