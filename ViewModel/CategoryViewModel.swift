
import Foundation
import Alamofire

class ContentViewViewModel: ObservableObject {
    @Published var gridItems: [GridItemModel] = []

    init() {
        fetchGridItems()
    }

    func fetchGridItems() {
        // 예시 데이터
        gridItems = [
            GridItemModel(imageName: "assiment", labelText: "Assignment"),
            GridItemModel(imageName: "workOut", labelText: "Work Out"),
            GridItemModel(imageName: "Daily", labelText: "Daily"),
            GridItemModel(imageName: "meet", labelText: "Meet")
        ]
    }
}
