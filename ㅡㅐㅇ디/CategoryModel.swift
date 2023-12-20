//
//  CategoryModel.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2023/11/28.
//

import Foundation

struct CategoryModel: Identifiable {
    let id: UUID
    let title: String

    init(title: String) {
        self.id = UUID() // 고유 식별자 생성
        self.title = title
    }
}

