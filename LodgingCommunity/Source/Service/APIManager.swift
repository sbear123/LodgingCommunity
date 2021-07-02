//
//  APIManager.swift
//  LodgingCommunity
//
//  Created by 박지현 on 2021/07/02.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class APIManager: BaseAPI {
    func getAPI() -> Observable<Data> {
        return Observable<Data>.create { observer in
            AF.request(self.baseURL, method: .get)
                .validate(statusCode: 200..<400)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let data = try! JSONDecoder().decode(Data.self, from: json["data"].rawData())
                        observer.onNext(data)
                    case .failure(let err):
                        observer.onError(err)
                    }
                }
            return Disposables.create()
        }
    }
}
