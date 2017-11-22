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
        property("A developer can not get a negative number of Maxibon") <- forAll({ (numberOfMaxibonsToGet: Int) -> Testable in
            
            let developer = Developer(name: "Developer", numberOfMaxibonsToGet: numberOfMaxibonsToGet)
            print("Developer numberOfMaxibonsToGet \(developer.numberOfMaxibonsToGet)")
            return developer.numberOfMaxibonsToGet >= 0
        })
    }
    
    func testDeveloperName() {
        property("A developer has a correct name") <- forAll({ (name: String) -> Testable in

            print("Text: \(name)")
            let developer = Developer(name: name, numberOfMaxibonsToGet: 1)
            print("Developer name: \(developer.name)")
            return developer.name == name
        })
    }
}
