//
//  TestModel.swift
//  Unduit
//
//  Created by Vivek Patel on 24/12/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import Foundation
struct DeviceDiagnostic:Codable {
    var response:[Category] = []
    var status:Bool
  
    
    enum CodingKeys:String,CodingKey {
        case response
        case status
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        response = try container.decodeIfPresent([Category].self, forKey: .response) ?? []
        status = try (container.decodeIfPresent(Bool.self, forKey: .status) ?? false)
    }
}
struct Category:Codable {
    var id:String?
    var parentId:String?
    var testCase:String?
    var question:String?
    var icon:String?
    var image:String?
    var sequence:String?
    var status:String?
    var subCategory:[Category] = []
    var testStatus:TestCaseType?
    var isSelected = false
    enum CodingKeys:String,CodingKey {
        //Old
        case id
        case parentId = "parent_id"
        case testCase = "test_case"
        case question
        case icon
        case image
        case sequence
        case status
        case subCategory = "child_test_case"
        case testStatus = "pass_status"
    }
    init(){}
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //Old
        id = try container.decodeIfPresent(String.self, forKey: .id)
        parentId = try container.decodeIfPresent(String.self, forKey: .parentId)
        testCase = try container.decodeIfPresent(String.self, forKey: .testCase)
        question = try container.decodeIfPresent(String.self, forKey: .question)
        icon = try container.decodeIfPresent(String.self, forKey: .icon)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        sequence = try container.decodeIfPresent(String.self, forKey: .sequence)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        testStatus = try container.decodeIfPresent(TestCaseType.self, forKey: .testStatus)
        do {
            subCategory = try container.decode([Category].self, forKey: .subCategory)
        } catch  {}
    }
    
}
