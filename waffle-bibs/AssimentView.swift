//
//  AssimentView.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2023/11/27.
import SwiftUI

struct AssimentView: View {
    var data: GridItemModel
    @Environment(\.presentationMode) var presentationMode // 환경 변수 추가
    
    @State private var items: [String] = ["항목 1", "항목 2"] // list item
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

    // Header View
    var headerView: some View {
        HStack {
          
            
            
            backButton
            Spacer()
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

    // List and New Item View
    var listAndNewItemView: some View {
        VStack {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
            }
            
            TextField("새 항목", text: $newItem)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
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
