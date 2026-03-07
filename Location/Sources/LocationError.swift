import Foundation

/// Errors that ``LocationManager`` can throw.
///
/// Use these to handle common failure modes when requesting
/// the user's location.
///
/// ```swift
/// do {
///     let location = try await locationManager.currentLocation()
/// } catch LocationError.unauthorized {
///     // Prompt the user to enable location in Settings
/// } catch LocationError.unavailable {
///     // Location services are disabled system-wide
/// }
/// ```
public enum LocationError: LocalizedError {
    /// The user has denied or restricted location access.
    case unauthorized

    /// Location services are disabled system-wide.
    case unavailable

    /// A location update was not received within the expected time.
    case timeout

    /// CoreLocation returned an error.
    case underlying(Error)

    public var errorDescription: String? {
        switch self {
        case .unauthorized:
            "Location access is not authorized. Enable it in Settings."
        case .unavailable:
            "Location services are not available on this device."
        case .timeout:
            "Location request timed out."
        case .underlying(let error):
            error.localizedDescription
        }
    }
}
