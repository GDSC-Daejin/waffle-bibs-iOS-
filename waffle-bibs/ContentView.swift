//
//  ContentView.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2023/11/02.
//
import SwiftUI
import Alamofire

struct ContentView: View {
    @State private var gridItems: [GridItemModel] = []
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.CustomBlue
                
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 11), GridItem(.flexible(), spacing: 11)]) {
                    ForEach(gridItems.indices, id: \.self) { index in
                        let item = gridItems[index]
                        NavigationLink(destination: DetailView(itemIndex: index, gridItems: gridItems)) {
                            VStack {
                                Image(item.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 48, height: 48)
                                    .clipped()
                                
                                Text(item.labelText)
                                    .font(.custom("Inter-Bold", size: 14))
                            }
                            .frame(width: 152, height: 148, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                    }
                }
                .padding(40)
            } .onAppear {
                fetchServerData()
            }
        }
        .navigationTitle("My Lists")
    }
    
    
    func fetchServerData() {
        let url = "http://158.179.166.114:8080/"
        AF.request(url, method: .get).responseDecodable(of: [CategoryModel].self) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let data):
                    self?.gridItems = data.map { GridItemModel(imageName: $0.title.lowercased(), labelText: $0.title) }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}



struct DetailView: View {
    var itemIndex: Int
    let gridItems: [GridItemModel] // gridItems 배열을 추가

    init(itemIndex: Int, gridItems: [GridItemModel]) {
        self.itemIndex = itemIndex
        self.gridItems = gridItems
    }
    
    var body: some View {
        switch itemIndex {
        case 0:
            AssimentView(data: gridItems[itemIndex]) // 필요한 데이터를 전달
            
        // 다른 인덱스에 대한 뷰를 여기에 추가
        default:
            Text("Detail View for Item \(itemIndex)")
        }
    }
}



extension Color {
    static let CustomBlue = Color("CustomBlue")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
