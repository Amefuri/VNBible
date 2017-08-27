//
//  VNDbAPI+Filter.swift
//  VNBible
//
//  Created by peerapat atawatana on 1/24/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import Foundation

//= != > >= < <=
public enum VNDbAPICommandFilterOperator: CustomStringConvertible {
    case equalTo
    case notEqualTo
    case greaterThan
    case greaterOrEqualTo
    case lessThan
    case lessOrEqualTo
    
    public var description: String {
        switch self {
        case .equalTo:
            return "="
        case .notEqualTo:
            return "!="
        case .greaterThan:
            return ">"
        case .greaterOrEqualTo:
            return ">="
        case .lessThan:
            return "<"
        case .lessOrEqualTo:
            return "<="
        }
    }
}

public enum VNDbAPICommandFilter: CustomStringConvertible {
    case query(filterOperator:VNDbAPICommandFilterOperator, id:Int)
    
    public var description : String {
        switch self {
        case .query(let filterOperator, let id):
            return "(id \(filterOperator) \(id))"
        }
    }
}
