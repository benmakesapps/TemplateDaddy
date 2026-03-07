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

    var body: some Scene {
        WindowGroup {
            Stack(router: AppRouter()) {
                Text("Hello World")
                    .appToolbar()
            }
            .sheetStack(router: AppRouter())
        }
        .environment(serviceProvider)
    }
}
