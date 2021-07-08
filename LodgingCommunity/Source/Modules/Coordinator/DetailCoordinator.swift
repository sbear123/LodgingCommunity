//
//  DetailCoordinator.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/30.
//
import UIKit

protocol Coordinator: AnyObject {
    func pushToDetail(_ navigationController: UINavigationController?, pro: Product, id: Int)
}

class DetailCoordinator: Coordinator {
    func pushToDetail(_ navigationController: UINavigationController?, pro: Product, id: Int) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let detailVC = (storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController)!
        detailVC.vm.pro = pro
        detailVC.vm.productID = id
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
