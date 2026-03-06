//
//  Destination.swift
//  Navigation
//
//  Created by Benjamin Kelsey on 3/6/26.
//

/// A type representing a navigable screen in your app.
///
/// Conform an enum to this protocol with one case per screen.
/// Use associated values for parameterised routes.
///
/// ```swift
/// enum AppDestination: Destination {
///     case home
///     case settings
///     case profile(userId: String)
///
///     var id: Self { self }
/// }
/// ```
public protocol Destination: Identifiable, Hashable {}
