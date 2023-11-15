//
//  ContentView.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2023/11/02.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // 배경색 설정
                Color.CustomBlue
                // 그리드 구성
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(0..<5, id: \.self) { index in
                        // 각 셀을 NavigationLink로 래핑
                        NavigationLink(destination: DetailView(itemIndex: index)) {
                            VStack {
                                // 셀 내용: 이미지와 레이블
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                Text("Item \(index)")
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
    }
}

struct DetailView: View {
    var itemIndex: Int

    var body: some View {
        Text("Detail View for Item \(itemIndex)")
            .navigationTitle("Detail")
    }
}

// Color 확장
extension Color {
    static let CustomBlue = Color("CustomBlue")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
