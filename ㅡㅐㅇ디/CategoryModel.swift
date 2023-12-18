//
//  CategoryModel.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2023/11/28.
//

import Foundation



struct CategoryModel: Codable, Identifiable {
    let id: UUID = UUID()  // 고유 ID 생성
    let title: String
}

