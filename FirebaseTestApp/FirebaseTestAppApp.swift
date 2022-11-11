//
//  FirebaseTestAppApp.swift
//  FirebaseTestApp
//
//  Created by Ashfaq on 12/11/22.
//

import SwiftUI
import Firebase

@main
struct FirebaseTestAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            let viewmodel = WriteViewModel()
            let viewmodel2 = AppViewModel()
            LoginView()
                .environmentObject(viewmodel)
                .environmentObject(viewmodel2)
        }
    }
}
