import Testing
@testable import Navigation

@Suite("SheetManager")
struct SheetManagerTests {

    @Test func initiallyNil() {
        let manager = SheetManager<TestDestination>()
        #expect(manager.destination == nil)
    }

    @Test func showSetsDestination() {
        let manager = SheetManager<TestDestination>()
        manager.show(.alpha)
        #expect(manager.destination == .alpha)
    }

    @Test func showOverwritesDestination() {
        let manager = SheetManager<TestDestination>()
        manager.show(.alpha)
        manager.show(.beta)
        #expect(manager.destination == .beta)
    }

    @Test func dismissClearsDestination() {
        let manager = SheetManager<TestDestination>()
        manager.show(.alpha)
        manager.dismiss()
        #expect(manager.destination == nil)
    }

    @Test func dismissWhenNilIsNoOp() {
        let manager = SheetManager<TestDestination>()
        manager.dismiss()
        #expect(manager.destination == nil)
    }
}
