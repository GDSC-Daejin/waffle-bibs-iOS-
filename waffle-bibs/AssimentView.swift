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
    @State private var todoItems: [TodoItemGet] = []
    @FocusState private var isFocused: Bool
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                headerView
                List {
                    ForEach(todoItems.indices, id: \.self) { index in
                        ZStack {
                            if editingIndex == index {
                                TextField("", text: Binding(
                                    get: { self.todoItems[index].contents ?? "" },
                                    set: { self.todoItems[index].contents = $0 }
                                ))
                                .textFieldStyle(DefaultTextFieldStyle())
                                .padding(.leading, 20)
                                .background(Color.clear)
                                .onSubmit {
                                    updateTodoItem(at: index)
                                    editingIndex = nil
                                }
                                .focused($isFocused)
                            } else {
                                Text(todoItems[index].contents ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 20)
                                    .onTapGesture {
                                        editingIndex = index
                                    }
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
                .onAppear(perform: fetchTodoItems)
                .animation(.easeInOut(duration: 0.3))
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
            // Add new empty item at the end
            self.items.append("")
            self.todoItems.append(TodoItemGet(id: -1, contents: "", completeChk: true, categoryTitle: ""))
            self.editingIndex = self.items.count - 1
            self.isFocused = true
        }) {
            ZStack {
                Image("addBack").resizable().frame(width: 23, height: 23)
                Image("addFore").resizable().frame(width: 17, height: 17)
            }
        }
    }
    
    //MARK: -
    
    func fetchTodoItems() {
        let url = "https://waffle-bibs.p-e.kr:443/1/todo"
        AF.request(url, method: .get).responseDecodable(of: [TodoItemGet].self) { response in
            switch response.result {
            case .success(let items):
                DispatchQueue.main.async {  // Ensure UI updates on the main thread
                    self.todoItems = items.sorted { $0.id > $1.id }.prefix(8).map { $0 }  // No need to convert to Array
                    self.items = self.todoItems.map { $0.contents ?? "" }
                }
            case .failure(let error):
                print("Error fetching todo items: \(error)")
            }
        }
    }

    func removeItem(at offsets: IndexSet) {
        for offset in offsets {
            let id = todoItems[offset].id
            
            let url = "https://waffle-bibs.p-e.kr:443/todo/\(id)"
            AF.request(url, method: .delete).response { response in
                switch response.result {
                case .success:
                    print("DELETE 요청 성공")
                    DispatchQueue.main.async {
                        self.todoItems.remove(at: offset)
                        self.items.remove(at: offset)
                        self.fetchTodoItems()  // Fetch the updated list to refill the gap
                        
                    }
                    print(id)
                case .failure(let error):
                    print("DELETE 요청 실패: \(error)")
                }
            }
        }
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
            NetworkManager.shared.postTodoItem(contents: items[index]) { result in
                switch result {
                case .success:
                    print("Todo item post 성공!")
                    // Fetch updated list after posting
                    DispatchQueue.main.async {
                        fetchTodoItems()
                    }
                case .failure(let error):
                    print("Todo item post 실패: \(error)")
                }
            }
        }
    }
    
    func updateTodoItem(at index: Int) {
           
         let id = todoItems[index].id
           guard let contents = todoItems[index].contents else { return }

           let parameters: [String: Any] = ["complete_chk": true, "contents": contents]
           let url = "https://waffle-bibs.p-e.kr:443/todo/\(id)/update"

            AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).response { response in
                switch response.result {
                case .success:
                    print("PATCH 요청 성공")

                    DispatchQueue.main.async {
                        fetchTodoItems()
                    }
                case .failure(let error):
                    print("PATCH 요청 실패: \(error)")
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
