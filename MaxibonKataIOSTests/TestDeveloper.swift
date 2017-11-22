//
//  TestDeveloper.swift
//  MaxibonKataIOSTests
//
//  Created by Óscar Manrique on 22/11/17.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import XCTest
import SwiftCheck
@testable import MaxibonKataIOS

class TestDeveloper: XCTestCase {
    
    func testDeveloperNumberOfMaxibonsToGet() {
        property("A developer can not get a negative number of Maxibon") <- forAll({ (developer: Developer) -> Testable in
            print("\(developer.name) gets \(developer.numberOfMaxibonsToGet) maxibon")
            return developer.numberOfMaxibonsToGet >= 0
        })
    }
}
