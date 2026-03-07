import Testing
@testable import Navigation

@Suite("StackManager")
struct StackManagerTests {

    @Test func initiallyEmpty() {
        let manager = StackManager<TestDestination>()
        #expect(manager.path.isEmpty)
    }

    @Test func pushAppendsToPath() {
        let manager = StackManager<TestDestination>()
        manager.push(.alpha)
        #expect(manager.path.count == 1)
    }

    @Test func pushMultipleDestinations() {
        let manager = StackManager<TestDestination>()
        manager.push(.alpha)
        manager.push(.beta)
        manager.push(.detail(id: 42))
        #expect(manager.path.count == 3)
    }

    @Test func popRemovesLast() {
        let manager = StackManager<TestDestination>()
        manager.push(.alpha)
        manager.push(.beta)
        manager.pop()
        #expect(manager.path.count == 1)
    }

    @Test func popWhenEmptyIsNoOp() {
        let manager = StackManager<TestDestination>()
        manager.pop()
        #expect(manager.path.isEmpty)
    }

    @Test func popToRootClearsAll() {
        let manager = StackManager<TestDestination>()
        manager.push(.alpha)
        manager.push(.beta)
        manager.push(.detail(id: 1))
        manager.popToRoot()
        #expect(manager.path.isEmpty)
    }

    @Test func popToRootWhenEmptyIsNoOp() {
        let manager = StackManager<TestDestination>()
        manager.popToRoot()
        #expect(manager.path.isEmpty)
    }
}
