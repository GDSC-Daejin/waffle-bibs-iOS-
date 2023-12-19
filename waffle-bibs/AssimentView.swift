//
//  AssimentView.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2023/11/27.
//

import SwiftUI

struct AssimentView: View {
    var data: GridItemModel

    var body: some View {
        // 'assiment'와 관련된 UI 구성
        VStack{
            Text("Assiment View for \(data.labelText)")
            Text("2132112")
            // 여기에 더 많은 UI 컴포넌트를 추가
        }
    }
}

struct AssimentView_Previews: PreviewProvider {
    static var previews: some View {
        // GridItemModel의 샘플 인스턴스 생성
        let sampleItem = GridItemModel(imageName: "assiment", labelText: "Assignment")
        // 샘플 인스턴스를 AssimentView에 전달
    //    AssimentView(data: sampleItem)
    }
}
