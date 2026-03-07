//
//  AppTest.swift
//  Tests
//
//  Created by Benjamin Kelsey on 3/6/26.
//

import Testing

struct AppTest {
    @Test func truePasses() async throws {
        #expect(true)
    }
}
