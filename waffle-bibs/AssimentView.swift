//
//  AssimentView.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2023/11/27.

import SwiftUI
import Alamofire
struct AssimentView: View {
    var data: GridItemModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var items: [String] = Array(repeating: "", count: 8)
    @State private var editingIndex: Int? = nil
    @State private var newItem: String = ""
    
    
    var body: some View {
          ZStack {
              VStack(alignment: .leading) {
                  headerView
                  ScrollView {
                      VStack(spacing: 10) {
                          ForEach(0..<items.count, id: \.self) { index in
                              ZStack {
                                  if editingIndex == index {
                                      TextField("새 항목", text: $items[index])
                                          .textFieldStyle(RoundedBorderTextFieldStyle())
                                          .onSubmit {
                                              editingIndex = nil
                                          }
                                  } else {
                                      Text(items[index].isEmpty ? "비어있는 항목" : items[index])
                                  }
                              }
                              .frame(height: 120)
                              .frame(maxWidth: .infinity)
                              .background(Color("CustomBlue"))
                              .cornerRadius(8)
                              .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                  Button(role: .destructive) {
                                      removeItem(at: index)
                                  } label: {
                                      Label("삭제", systemImage: "trash")
                                  }
                              }
                          }
                      }
                      .padding(.horizontal)
                  }
                  .background(Color.white)
              }
              .navigationBarHidden(true)
          }
      }

    var headerView: some View {
        HStack {
            backButton
            HeadText
            Spacer()
            addButton
        }
        .padding()
    }

    var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image("backBtn").resizable().frame(width: 20, height: 20)
        }
    }
    
    var HeadText: some View {
        Text("Assiment")
            .font(.custom("Inter", size: 30))
            .bold()
            .foregroundColor(Color("CustomFont"))
    }
    
    var addButton: some View {
        Button(action: {
            if let firstEmptyIndex = items.firstIndex(where: { $0.isEmpty }) {
                editingIndex = firstEmptyIndex
            }
        }) {
            ZStack {
                Image("addBack").resizable().frame(width: 23, height: 23)
                Image("addFore").resizable().frame(width: 17, height: 17)
            }
        }
    }
    
    //MARK: -

    
    func removeItem(at index: Int) {
        items.remove(at: index)
        items.append("") // 맨 끝에 새로운 빈 항목 추가
    }

    func addNewItem() {
        if !newItem.isEmpty {
            if let firstEmptyIndex = items.firstIndex(where: { $0.isEmpty }) {
                items[firstEmptyIndex] = newItem
                newItem = ""
            }
        }
    }
}
    


struct AssimentView_Previews: PreviewProvider {
    static var previews: some View {
        AssimentView(data: GridItemModel(imageName: "assiment", labelText: "Assignment"))
    }
}

extension Color {
    static let CustomFont = Color("CustomFont")
}
