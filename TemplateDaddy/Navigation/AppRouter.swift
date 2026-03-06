//
//  AppRouter.swift
//  TemplateDaddy
//
//  Created by Benjamin Kelsey on 3/6/26.
//

import SwiftUI
import Navigation

struct AppRouter: Router {
    @ViewBuilder
    func view(for destination: AppDestination) -> some View {
        switch destination {
        case .helloWorld:
            HelloWorldCoordinator()
        case .settings:
            SettingsCoordinator()
        }
    }
}
