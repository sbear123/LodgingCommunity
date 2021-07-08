//
//  FavoriteViewModel.swift
//  LodgingCommunity
//
//  Created by 박지현 on 2021/07/03.
//

import Foundation
import RxSwift
import RxCocoa

class FavoriteViewModel {
    let service = DataService.shared
    let disposeBag = DisposeBag()
    
    var data: Data = Data()
    var pagingData = BehaviorRelay(value: [Product]())
    var pagingCnt = 0
    var isEnd = false
    var alertMsg = PublishRelay<String>()
    
    init() {
        service.favoriteData.bind(onNext: { list in
            self.data.totalCount = list.count
            self.data.product = list
            self.paging(isRefresh: true)
        }).disposed(by: disposeBag)
    }
    
    func paging(isRefresh: Bool) {
        let list = data.product
        if pagingCnt * 20  > list.count && !isRefresh {
            alertMsg.accept("마지막 페이지 입니다.")
            return
        }
        pagingCnt += 1
        var paging: [Product] = []
        let cnt = self.pagingCnt
        var slice: ArraySlice<Product> = ArraySlice()
        if (cnt * 20) > list.count {
            slice = list[0..<list.count]
        }
        else {
            slice = list[0..<(cnt * 20)]
        }
        paging = Array(slice)
        pagingData.accept(paging)
    }
    
    func tapFavorite(cnt: Int) -> Bool {
        let id = data.product[cnt].id
        if UserDefaults.standard.string(forKey: "\(id)") == nil {
            let now = Date().toString()
            UserDefaults.standard.set(now, forKey: "\(id)")
            return true
        }
        else {
            UserDefaults.standard.removeObject(forKey: "\(id)")
            return false
        }
    }
    
}
