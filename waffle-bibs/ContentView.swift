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
                        NavigationLink(destination: destinationView(item: item)) {
                            VStack {
                                Image(item.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 48, height: 48)
                                    .clipped()
                                Text(item.labelText)
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

    @ViewBuilder
    private func destinationView(item: GridItemModel) -> some View {
        
        print(item.labelText) // 여기에 추가
        return VStack {
            
            switch item.labelText {
                
            case "Assignment":
                AssimentView(data: item)
            case "Work Out":
                WorkoutView()
            case "Daily":
                DailyView()
            case "Meet":
                MeetView()
            default:
                Text("Not Found")
            }
        }
    }
}
//
//
//
//struct DetailView: View {
//    var item: GridItemModel
//
//    var body: some View {
//        Text("Detail View for \(item.labelText)")
//            .navigationTitle(item.labelText)
//    }
//}
//


// Color extension 및 ContentView_Previews 유지


extension Color {
    static let CustomBlue = Color("CustomBlue")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
