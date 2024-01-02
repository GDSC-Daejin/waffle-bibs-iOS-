//
//  TodoModel.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2024/01/01.
//

import Foundation


// MARK: - Welcome
struct TodoPostModel: Codable {
    let categoryTitle: String?
    let completeChk: Bool?
    let contents: String?
    let id: Int?
    let startTime, title: String?

    enum CodingKeys: String, CodingKey {
        case categoryTitle
        case completeChk = "complete_chk"
        case contents, id, startTime, title
    }
}
