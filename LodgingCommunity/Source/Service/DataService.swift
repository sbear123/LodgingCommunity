//
//  ListService.swift
//  LodgingCommunity
//
//  Created by 박지현 on 2021/07/03.
//

import RxSwift
import RxCocoa

protocol DataServiceType {
    var currentData: Data { get }
    
    func getData()
}

class DataService: DataServiceType {
    static let shared = DataService()
    
    let api: APIManager = APIManager()
    var apiKey: Int = 0
    let disposeBag = DisposeBag()
    
    var currentData: Data = Data()
    var dataRelay = PublishRelay<Data>()
    var favoriteData = PublishRelay<[Product]>()
    
    func getData() {
        apiKey += 1
        api.getAPI(api: "/\(apiKey).json").subscribe(
            onSuccess: { data in
                self.currentData.totalCount = data.totalCount
                self.currentData.product += data.product
                self.getData()
            },
            onFailure: { err in
                self.refreshFavorite()
                print(err)
            }
        ).disposed(by: disposeBag)
    }
    
    func refreshFavorite() {
        self.dataRelay.accept(self.currentData)
        let favoriteList = currentData.product.filter( {(value: Product) -> Bool in
            return value.favorite
        })
        favoriteData.accept(favoriteList)
    }
    
}
