//
//  ContentView.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2023/11/02.
//
import SwiftUI


struct ContentView: View {
    
    let gridItems = [
        GridItemModel(imageName: "assiment", labelText: "Aassignment"),
        GridItemModel(imageName: "workOut", labelText: "work out"),
        GridItemModel(imageName: "Daily", labelText: "Daily"),
        GridItemModel(imageName: "meet", labelText: "meet")
    ]
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 배경색 설정
                Color.CustomBlue
                // 그리드 구성
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 11), GridItem(.flexible(), spacing: 11)]) {
                        
                        ForEach(gridItems.indices, id: \.self) { index in
                            let item = gridItems[index]
                            NavigationLink(destination: DetailView(itemIndex: index)) {
                                VStack {
                                    
                                    // 사용자 정의 이미지 로드
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
            }
            .navigationTitle("My Lists")
        }
    }
}

struct DetailView: View {
    var itemIndex: Int
    
    var body: some View {
        Text("Detail View for Item \(itemIndex)")
            .navigationTitle("Detail")
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
