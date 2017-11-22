//
//  TestKarumi.swift
//  MaxibonKataIOSTests
//
//  Created by Óscar Manrique on 22/11/17.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import XCTest
import SwiftCheck
@testable import MaxibonKataIOS

class TestKarumi: XCTestCase {
    

    func testIfDeveloperGrabMaxibonsThenShouldRestMoreThan2MaxibonsInTheFridge() {
        let karumi = KarumiHQs()
        
        property("checkIfDeveloperGrabMaxibonsThenShouldRestMoreThan2MaxibonsInTheFridge") <- forAll({ (developer: Developer) -> Testable in
            
            print("Num Maxibon before: \(karumi.maxibonsLeft)")
            karumi.openFridge(developer)
            print("Num Maxibon after: \(karumi.maxibonsLeft)")
            
            return karumi.maxibonsLeft >= 2
        })
    }
    
}
