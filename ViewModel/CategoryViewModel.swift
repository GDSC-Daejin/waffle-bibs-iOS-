
import Foundation
import Alamofire


class ContentViewViewModel: ObservableObject, Identifiable {
    @Published var gridItems: [CategoryModel] = []

    init() {
        fetchCategories()
    }

    func fetchCategories() {
        // 서버에서 카테고리 데이터를 가져오는 로직을 구현
        // 예시로 임시 데이터를 사용합니다.
        gridItems = [
            CategoryModel(title: "Assignment"),
            CategoryModel(title: "Work Out"),
            CategoryModel(title: "Daily"),
            CategoryModel(title: "Meet")
        ]
    }
}
