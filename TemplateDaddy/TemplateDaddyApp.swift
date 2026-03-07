//
//  TemplateDaddyApp.swift
//  TemplateDaddy
//
//  Created by Benjamin Kelsey on 3/5/26.
//

import SwiftUI
import Navigation

@main
struct TemplateDaddyApp: App {
    @State var serviceProvider = ServiceProvider()
    let router = AppRouter()

    var body: some Scene {
        WindowGroup {
            Stack(router: router) {
                Text("Hello World")
                    .appToolbar()
            }
            .sheetStack(router: router)
        }
        .environment(serviceProvider)
    }
}
