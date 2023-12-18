
import Foundation
import Alamofire


class GridItemViewModel: ObservableObject {
    @Published var gridItems: [CategoryModel] = []

    init() {
        fetchCategories()
    }

    func fetchCategories() {
        AF.request("http://158.179.166.114:8080/", method: .get).responseDecodable(of: [CategoryModel].self) { response in
            switch response.result {
            case .success(let categories):
                self.gridItems = categories
            case .failure(let error):
                print(error)
            }
        }
    }
}
