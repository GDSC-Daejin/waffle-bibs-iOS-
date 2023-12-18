//
//  Model.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2023/11/16.
//

import Foundation


struct GridItemModel: Identifiable {
    
    let id = UUID() // 고유 식별자 추가
    var imageName: String
    var labelText: String
}
