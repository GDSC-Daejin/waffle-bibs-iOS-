//
//  ContentView.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2023/11/02.
//
import SwiftUI

struct ContentView: View {
    let gridItems = [
        GridItemModel(imageName: "assiegment", labelText: "Aassignment"),
        GridItemModel(imageName: "workOut", labelText: "work out"),
        GridItemModel(imageName: "photo", labelText: "D"),
        GridItemModel(imageName: "photo", labelText: "Item 4")
        // 여기에 추가적인 아이템을 정의할 수 있습니다.
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 배경색 설정
                Color.CustomBlue
                // 그리드 구성
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(gridItems.indices, id: \.self) { index in
                        let item = gridItems[index]
                        NavigationLink(destination: DetailView(itemIndex: index)) {
                            VStack {
                                Image(systemName: item.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                Text(item.labelText)
                                    .font(.custom("Inter-Bold", size: 40))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150)
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("My Lists")
        }
        .onAppear {
            // 폰트 목록 출력
            for fontFamily in UIFont.familyNames {
                for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
                    print(fontName)
                }
            }
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
