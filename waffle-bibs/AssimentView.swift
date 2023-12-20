//
//  AssimentView.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2023/11/27.
import SwiftUI

struct AssimentView: View {
    var data: GridItemModel
    @Environment(\.presentationMode) var presentationMode // 환경 변수 추가
    
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                HStack {// leading은 왼쪽 정렬을 의미합니다.
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss() // 뒤로 가기 기능
                    })  {
                        Image("backBtn")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    Text("Assiment")
                        .font(.custom("Inter", size: 30))
                        .bold()
                        .foregroundColor(Color("CustomFont"))
                    
                    Spacer()
                    
                    
                    Button(action: {
                        // 오른쪽 첫 번째 버튼 액션
                    }) {
                        Image(systemName: "plus")
                    }
                    Button(action: {
                        // 오른쪽 두 번째 버튼 액션
                    }) {
                        Image(systemName: "ellipsis")
                    }
                }
                .padding()
                
                // 나머지 UI 구성
                Text("Assiment View for \(data.labelText)")
                // 여기에 더 많은 UI 컴포넌트를 추가
            }
            .navigationBarHidden(true) // 기본 네비게이션 바 숨김
        }
    }
}

struct AssimentView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleItem = GridItemModel(imageName: "assiment", labelText: "Assignment")
        AssimentView(data: sampleItem)
    }
}



extension Color {
    
    static let CustomFont = Color("CustomFont")
}

