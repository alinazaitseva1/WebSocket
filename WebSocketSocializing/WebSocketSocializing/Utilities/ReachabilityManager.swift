//
//  ReachabilityManager.swift
//  WebSocketSocializing
//
//  Created by Alina Zaitseva on 11/8/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityManager {
    
    // MARK: - Consts
    
    static  let shared = ReachabilityManager()  // Shared instance
    
    // MARK: - Vars
    
    var chatDelegate: ChatViewController?
    
    // Boolean to track network reachability
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .none
    }
    
    // Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.Connection = .none
    
    // Reachability instance for Network status monitoring
    let reachability = Reachability()!
    
    /// Called whenever there is a change in NetworkReachibility Status
    
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        switch reachability.connection {
        case .none:
            debugPrint("Network became unreachable")
        case .wifi:
            debugPrint("Network reachable through WiFi")
            chatDelegate?.noConnectionView.isHidden = true
            chatDelegate?.inputTextView.isHidden = false
        case .cellular:
            debugPrint("Network reachable through Cellular Data")
        }
    }
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }
    
}
