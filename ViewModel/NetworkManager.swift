//
//  NetworkManager.swift
//  waffle-bibs
//
//  Created by 이지훈 on 2024/01/04.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager() // 싱글톤 인스턴스 생성
    private init() {} // 외부에서 인스턴스 생성을 막음

    func postTodoItem(contents: String, complete: @escaping (Result<Void, Error>) -> Void) {
        let parameters: [String: Any] = [
            "complete_chk": true,
            "contents": contents
        ]

        let url = "https://waffle-bibs.p-e.kr:443/1/todo/add"
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Content-Type": "application/json"
        ]

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
            switch response.result {
            case .success:
                print("POST 요청 성공")
                complete(.success(()))
            case .failure(let error):
                print("POST 요청 실패: \(error)")
                complete(.failure(error))
            }
        }
    }
}
