//
//  DemoModsAppApp.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

@main
struct DemoModsAppApp: App {
    @StateObject private var vmHM = ViewModel.shared
    @StateObject private var netManager = NetRequset.shared
    @StateObject private var dbManager = DBManager.shared
    var body: some Scene {
        WindowGroup {
            FinalView()
                .environmentObject(vmHM)
                .environmentObject(netManager)
                .environmentObject(dbManager)
                .onAppear {
                    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")

                }
        }
    }
}
