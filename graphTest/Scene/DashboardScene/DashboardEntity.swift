//
//  DashboardEntity.swift
//  graphTest
//
//  Created by Javier Hernandez on 23/09/21.
//  
//

import Foundation
import UIKit
// Uncomment if using Realm
//import RealmSwift

/*
 Entity: contains basic model objects used by the Interactor, it is the model representation of the data.
 
 It can holds the model types to use from the view to the database.
 
 */

struct DashboardResponse: Decodable { //This can be changed to "Codable" protocol if needed
    var name    : String
    var value   : Int
    var isValid : Bool
    
    private enum CodingKeys: String, CodingKey {
        case name
        case value
        case isValid
    }
}

/*
 Uncomment if using RealmDatabase
class DashboardDatabase:Object {
    var name    : String = ""
    var value   : Int    = 0
    var isValid : Bool   = false
    override static func primaryKey() -> String? {
        return "name"
    }
}
 */

struct ServiceResponse: Decodable { //This can be changed to "Codable" protocol if needed
    var colors    : [String]
    var questions : [QuestionsResponse]
    
    private enum CodingKeys: String, CodingKey {
        case colors
        case questions

    }
}

struct QuestionsResponse: Decodable { //This can be changed to "Codable" protocol if needed
    var total : Int
    var text  : String
    var chartData : [ChartDataResponse]
    
    private enum CodingKeys: String, CodingKey {
        case total
        case text
        case chartData

    }
}

struct ChartDataResponse: Decodable { //This can be changed to "Codable" protocol if needed
    var text       : String
    var percetnage : Int
    
    private enum CodingKeys: String, CodingKey {
        case text
        case percetnage
    }
}
