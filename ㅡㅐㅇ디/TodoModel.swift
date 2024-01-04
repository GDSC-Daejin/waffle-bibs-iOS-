//
//  TodoModel.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2024/01/01.
//

import Foundation


struct TodoItem: Codable {
    let categoryTitle: String
    let completeChk: Bool
    let contents: String
    let startTime: String
}

struct TodoItemGet: Decodable {
    let id: Int
    let contents: String?
    let completeChk: Bool? 
    let categoryTitle: String
}
