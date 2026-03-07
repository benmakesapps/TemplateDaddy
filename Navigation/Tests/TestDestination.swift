@testable import Navigation

enum TestDestination: Destination {
    case alpha
    case beta
    case detail(id: Int)

    var id: Self { self }
}
