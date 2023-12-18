//
//  ContentView.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2023/11/02.
//
import SwiftUI
import Alamofire


struct ContentView: View {
    @StateObject var viewModel = ContentViewViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color.CustomBlue
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(viewModel.gridItems) { item in
                        NavigationLink(destination: DetailView(category: item)) {
                            VStack {
                                Image(item.title.lowercased()) // 이미지 이름은 title 속성을 사용
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 48, height: 48)
                                    .clipped()
                                Text(item.title)
                                    .font(.custom("Inter-Bold", size: 14))
                            }
                            .frame(width: 152, height: 148)
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
    var category: CategoryModel

    var body: some View {
        Text("Detail View for \(category.title)")
            .navigationTitle(category.title)
    }
}

// Color extension 및 ContentView_Previews 유지


extension Color {
    static let CustomBlue = Color("CustomBlue")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
