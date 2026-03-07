//
//  AppDestination.swift
//  TemplateDaddy
//
//  Created by Benjamin Kelsey on 3/5/26.
//

import Navigation

enum AppDestination: Destination {
    case helloWorld
    case settings

    var id: Self { self }
    
    var title: String? {
        switch self {
        case .settings: return "Settings"
        default: return nil
        }
    }
}
