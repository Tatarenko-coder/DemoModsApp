//
//  NetRequset.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import Foundation
import Network

class NetRequset: ObservableObject {
    static let shared = NetRequset()
    
    private var monitor: NWPathMonitor
    @Published var isConnectedToInternet: Bool = false
    
    private init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnectedToInternet = path.status == .satisfied
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
