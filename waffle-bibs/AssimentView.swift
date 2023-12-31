//
//  AssimentView.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2023/11/27.

import SwiftUI

struct AssimentView: View {
    
    var data: GridItemModel
    @Environment(\.presentationMode) var presentationMode // 환경 변수 추가
    
    @State private var items: [String] = Array(repeating: "", count: 8) // 8개의 비어 있는 항목으로 초기화
    @State private var newItem: String = ""
    @State private var showAlert = false
    @State private var showNewItemView = false
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                // Header UI
                headerView
                
                // List and New Item UI
                listAndNewItemView
            }
            .navigationBarHidden(true) // 기본 네비게이션 바 숨김
            
            // 새 항목 뷰 추가
            if showNewItemView {
                NewItemView(isPresented: $showNewItemView, newItem: $newItem, items: $items)
                    .frame(maxWidth: 300, maxHeight: 200)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
            }
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
            showNewItemView = true
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
            TextField("새 항목", text: $newItem)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(0..<items.count, id: \.self) { index in
                        Text(items[index].isEmpty ? "비어있는 항목" : items[index])
                            .frame(height: 120)
                            .frame(maxWidth: .infinity)
                            .background(Color("CustomBlue"))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
            }
            .background(Color.white)
        }
        .background(Color.white)
    }
    
    func addNewItem() {
        if !newItem.isEmpty {
            if let firstEmptyIndex = items.firstIndex(where: { $0.isEmpty }) {
                items[firstEmptyIndex] = newItem
            }
            newItem = "" // 입력 필드 초기화
        }
    }
}


struct NewItemView: View {
    @Binding var isPresented: Bool
    @Binding var newItem: String
    @Binding var items: [String]
    
    var body: some View {
        VStack {
            TextField("새 항목", text: $newItem)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("추가하기") {
                if !newItem.isEmpty {
                    items.append(newItem)
                    newItem = ""
                    isPresented = false
                }
            }
            .padding()
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
