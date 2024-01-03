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
                                        submitItem(at: index)
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
                isFocused = true
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
        // Loop through the indices that are being removed.
        for index in offsets {
            // For demonstration purposes, using the index as an ID.
            // Replace with actual ID obtained from the server.
            let id = index // Replace this with the actual ID.

            // Alamofire DELETE request
            let url = "https://waffle-bibs.p-e.kr:443/todo/\(id)"
            AF.request(url, method: .delete).response { response in
                switch response.result {
                case .success:
                    print("DELETE 요청 성공")
                    print(id)
                case .failure(let error):
                    print("DELETE 요청 실패: \(error)")
                }
            }
        }

        // Remove items from the local list after the DELETE request.
        items.remove(atOffsets: offsets)
        // You might need to fetch the updated list from the server after this.
        // Append an empty item if needed.
        items.append("")
    }

    
    
    func addNewItem() {
        if !newItem.isEmpty {
            if let firstEmptyIndex = items.firstIndex(where: { $0.isEmpty }) {
                items[firstEmptyIndex] = newItem
                newItem = ""
                
                
            }
        }
        
    }
    func submitItem(at index: Int) {
        if !items[index].isEmpty {
            let dateFormatter = ISO8601DateFormatter()
            let currentTime = dateFormatter.string(from: Date())
            
            let parameters: [String: Any] = [
                "complete_chk": true,
                "contents": items[index]
            ]
            
            let url = "https://waffle-bibs.p-e.kr:443/1/todo/add"
            let headers: HTTPHeaders = [
                "accept": "*/*",
                "Content-Type": "application/json"
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
                switch response.result {
                case .success:
                    print("POST 요청 성공")
                    print("--")
                case .failure(let error):
                    print("POST 요청 실패: \(error)")
                }
            }
        }
        
    }
    
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
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
