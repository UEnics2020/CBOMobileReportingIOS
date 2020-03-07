//
//  eExpanse.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 16/05/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit
public enum eExpanse : String, CaseIterable{
    case None
    case TA
    case DA
    case SERVER
    
    static func valueOf(_ label: String) -> eExpanse {
        var exp = self.allCases.first{ "\($0)" == label }
        if exp == nil {
            exp = None
        }
        return exp!
    }
    
    
    
    private static let values: [eExpanse] = eExpanse.allCases.map { $0 }
    
    
    static func getExp(at index: Int) -> eExpanse? {
        if index >= 0 && index < values.count {
            return values[index]
        } else {
            return nil
        }
    }
    
}

extension eExpanse {
    func name() -> String{
        self.rawValue
    }
}

//enum Status: Int {
//    case online = 0
//    case offline = 1
//    case na = 2
//}
//// enum as string
//let enumName = "\(Status.online)" // `online`
//
//// enum as int value
//let enumValue = Status.online.rawValue // 0
//
//// enum from int
//let enumm = Status.init(rawValue: 1)
