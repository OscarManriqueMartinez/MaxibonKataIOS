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
        
        property("checkIfDeveloperGrabMaxibonsThenShouldRestMoreThan2MaxibonsInTheFridge") <- forAll({ (developer: Developer) -> Testable in
            
            let karumi = KarumiHQs()
            
            print("Num Maxibon before: \(karumi.maxibonsLeft)")
            karumi.openFridge(developer)
            print("Num Maxibon after: \(karumi.maxibonsLeft)")
            
            return karumi.maxibonsLeft >= 2
        })
    }
    
    func testIfDeveloperHungryGrabMaxibonsThenShouldRestMoreThan2MaxibonsInTheFridge() {
        
        property("checkIfDeveloperHungryGrabMaxibonsThenShouldRestMoreThan2MaxibonsInTheFridge") <- forAll( Developer.arbitraryHungry){ (developer: Developer) -> Testable in
            
            let karumi = KarumiHQs()
            
            print("developer.numberOfMaxibonsToGet: \(developer.numberOfMaxibonsToGet)")
            karumi.openFridge(developer)
            
            let maxibons = self.numberMaxibonsFridge(maxibonsLeft: karumi.maxibonsLeft, numberOfMaxibonsToGet: developer.numberOfMaxibonsToGet)
            
            print("maxibonsLeft: \(maxibons)")
            
            return karumi.maxibonsLeft == maxibons
        }
    }
    
    func testIfDeveloperNoHungryGrabMaxibonsThenShouldRestMoreThan2MaxibonsInTheFridge() {
        
        property("checkIfDeveloperNoHungryGrabMaxibonsThenShouldRestMoreThan2MaxibonsInTheFridge") <- forAll( Developer.arbitraryNotSoHungry){ (developer: Developer) -> Testable in
            
            let karumi = KarumiHQs()
            
            print("developer.numberOfMaxibonsToGet: \(developer.numberOfMaxibonsToGet)")
            karumi.openFridge(developer)
            
            let maxibons = self.numberMaxibonsFridge(maxibonsLeft: karumi.maxibonsLeft, numberOfMaxibonsToGet: developer.numberOfMaxibonsToGet)
            
            print("maxibonsLeft: \(maxibons)")
            
            return karumi.maxibonsLeft == maxibons
        }
    }
    
    func testIfDevelopersGrabMaxibonsThenShouldRestMoreThan2MaxibonsInTheFridge() {
        
        property("checkIfDevelopersGrabMaxibonsThenShouldRestMoreThan2MaxibonsInTheFridge") <- forAll(){ (developers: ArrayOf<Developer>) -> Testable in
            
            let karumi = KarumiHQs()
            
            karumi.openFridge(developers.getArray)
            
            return karumi.maxibonsLeft > 2
        }.verbose
    }

    func testCheckPrintInSlackBuyMoreMaxibom() {
        
        property("checkPrintInSlackBuyMoreMaxibom") <- forAll(Developer.arbitraryHungry){ (developer: Developer) -> Testable in
            let chat = ChatMock()
            let karumi = KarumiHQs(chat: chat)
            
            karumi.openFridge(developer)
            
            return chat.isSend
        }
    }
    
    
    
    func numberMaxibonsFridge(maxibonsLeft: Int, numberOfMaxibonsToGet: Int) -> Int{
        var maxibons = maxibonsLeft - numberOfMaxibonsToGet
        
        if maxibons < 0{
            maxibons = 10
        }
        
        if maxibons <= 2{
            maxibons += 10
        }
        
        return maxibons
    }
}

class ChatMock: Chat {

    var isSend: Bool = false
    
    func send(message: String) {
        isSend = true
        print("------->"+message)
    }
}
