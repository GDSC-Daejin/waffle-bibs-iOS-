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
    @FocusState private var isFocused: Bool
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                headerView
                List {
                    ForEach(0..<items.count, id: \.self) { index in
                        ZStack {
                            if editingIndex == index {
                                TextField("", text: $items[index])
                                    .textFieldStyle(DefaultTextFieldStyle())
                                    .padding(.leading, 20)
                                    .background(Color.clear)
                                    .onSubmit {
                                        editingIndex = nil
                                    }
                                    .focused($isFocused)
                            } else {
                                Text(items[index].isEmpty ? "" : items[index])
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 20)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width - 40, height: 48)
                        .background(Color("CustomBlue"))
                        .cornerRadius(8)
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: removeItem)
                    
                }
                .listStyle(PlainListStyle())

            }
            .navigationBarHidden(true)
        }
    }



    //MARK: - Header

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
                isFocused = true // 포커스 상태를 true로 설정
            }
        }) {
            ZStack {
                Image("addBack").resizable().frame(width: 23, height: 23)
                Image("addFore").resizable().frame(width: 17, height: 17)
            }
        }
    }
    
    //MARK: -

    
    func removeItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        items.append("")
    }

  
    func addNewItem() {
        if !newItem.isEmpty {
            if let firstEmptyIndex = items.firstIndex(where: { $0.isEmpty }) {
                items[firstEmptyIndex] = newItem
                newItem = ""

                // 현재 시간을 ISO 8601 형식으로 변환
                let dateFormatter = ISO8601DateFormatter()
                let currentTime = dateFormatter.string(from: Date())

                // Alamofire를 사용한 POST 요청
                let url = "https://waffle-bibs.p-e.kr:443/1/todo/add"
                let headers: HTTPHeaders = [
                    "accept": "*/*",
                    "Content-Type": "application/json"
                ]
                let parameters: [String: Any] = [
                 //   "categoryTitle": "string",  // 예시 값
                 //   "complete_chk": true,       // 예시 값
                    "contents": items[firstEmptyIndex], // 텍스트 필드의 값
                  //  "id": 1,                    // 예시 값
                  //  "startTime": currentTime,   // 현재 시간
                 // "title": "string"           // 예시 값
                ]

                AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
                    switch response.result {
                    case .success:
                        print("POST 요청 성공")
                    case .failure(let error):
                        print("POST 요청 실패: \(error)")
                    }
                }
            }
        }
    }

}
    



struct AssimentView_Previews: PreviewProvider {
    static var previews: some View {
        AssimentView(data: GridItemModel(imageName: "assiment", labelText: "Assignment"))
        // Removed the isFocused parameter
    }
    
}

extension Color {
    static let CustomFont = Color("CustomFont")
}
