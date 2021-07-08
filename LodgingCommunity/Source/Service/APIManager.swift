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
    func getAPI(api: String) -> Single<Data> {
        return Single<Data>.create { single in
            AF.request(self.baseURL + api, method: .get)
                .validate(statusCode: 200..<400)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let msg = json["msg"].rawValue as! String
                        let code = json["code"].rawValue as! Int
                        if code == 400 {
                            let err = CustomError.Custom(msg: msg)
                            single(.failure(err))
                            return
                        }
                        let data = try! JSONDecoder().decode(Data.self, from: json["data"].rawData())
                        single(.success(data))
                    case .failure:
                        let err = CustomError.Custom(msg: "서버연결 실패")
                        single(.failure(err))
                    }
                }
            return Disposables.create()
        }
    }
}
