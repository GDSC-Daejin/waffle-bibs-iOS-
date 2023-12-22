//
//  AssimentView.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2023/11/27.

import SwiftUI

struct AssimentView: View {
    var data: GridItemModel
    @Environment(\.presentationMode) var presentationMode // 환경 변수 추가
    
    @State private var items: [String] = [] // list item
    @State private var newItem: String = ""
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                // Header UI
                headerView

                // List and New Item UI
                listAndNewItemView
            }
            .navigationBarHidden(true) // 기본 네비게이션 바 숨김
        }
    }


//MARK: - Header 추가

    // Header View
    var headerView: some View {
        HStack {
          
            backButton
            HeadText
            Spacer()
            deleteButton
            addButton
        }
        .padding()
    }

    var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss() // 뒤로 가기 기능
        }) {
            Image("backBtn")
                .resizable()
                .frame(width: 20, height: 20)
        }
    }
    
    var HeadText: some View {
        Text("Assiment")
            .frame(alignment: .leading)
            .font(.custom("Inter", size: 30))
            .bold()
            .foregroundColor(Color("CustomFont"))
        
    }

    var deleteButton: some View {
        Button(action: {
            // 오른쪽 첫 번째 버튼 액션
        }) {
            Image("deleteBtn")
                .resizable()
                .frame(width: 30, height: 30)
        }
    }

    var addButton: some View {
        Button(action: {
            addNewItem()
        }) {
            ZStack {
                Image("addBack")
                    .resizable()
                    .frame(width: 23, height: 23)
                Image("addFore")
                    .resizable()
                    .frame(width: 17, height: 17)
            }
        }
    }
//MARK: -

    // List and New Item View
    var listAndNewItemView: some View {
            VStack {
                ScrollView {
                    VStack(spacing: 10) { // 항목 사이의 여백 설정
                        ForEach(items, id: \.self) { item in
                            Text(item)
                                .frame(height: 120) // 항목 높이 설정
                                .frame(maxWidth: .infinity)
                                .background(Color("CustomBlue")) // 항목 배경 색상
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal) // 가로 여백 제거
                }
                .background(Color.white) // List 전체 배경색 설정

                // 새 항목 추가 UI
                TextField("새 항목", text: $newItem)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            .background(Color.white) // VStack 배경 색상
        }


    func addNewItem() {
        if !newItem.isEmpty {
            items.append(newItem)
            newItem = "" // 입력 필드 초기화
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
