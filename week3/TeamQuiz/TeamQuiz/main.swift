//
//  main.swift
//  TeamQuiz
//
//  Created by 오민호 on 2017. 7. 20..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation

class Person {
    var name : String
    lazy var fingerPrint : FingerPrint = {
        [unowned self] in
       return FingerPrint(id: 0101, person: self)
    }()
    var apartment : Apartment?
    var creditCard : CreditCard?
    
    init(name : String) {
        self.name = name
        print("사람 생성")
    }
    deinit {
         print("사람 해제")
    }
}

class FingerPrint {
    let id : Int
    var person : Person
    init(id : Int, person : Person) {
        self.id = id
        self.person = person
        print("지문 생성")
    }
    deinit {
        print("지문 해제")
    }
}

class Apartment {
    var unit : String
    weak var tenant : Person?
    
    init(unit : String, tenant :Person? = nil) {
        self.unit = unit
        self.tenant = tenant
        print("아파트 생성")
    }
    
    deinit {
        print("아파트 해제")
    }
}

class CreditCard {
    let cardNumber : Int
    unowned var customer : Person
    
    init(cardNumber : Int, customer : Person) {
        self.cardNumber = cardNumber
        self.customer = customer
        print("신용카드 생성")
    }
    deinit {
         print("신용카드 해제")
    }
}

var john: Person? = Person(name: "john")
var fingerPrint : FingerPrint? = FingerPrint(id: 0101, person: john!)
//john?.fingerPrint = fingerPrint

var apartment : Apartment? = Apartment(unit: "AAA", tenant: john)
var creditCard : CreditCard? = CreditCard(cardNumber: 0000, customer: john!)
john?.apartment = apartment
john?.creditCard = creditCard

john = nil
apartment = nil
creditCard = nil
fingerPrint = nil
