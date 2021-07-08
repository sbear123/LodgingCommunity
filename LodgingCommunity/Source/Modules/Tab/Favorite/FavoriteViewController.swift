//
//  FavoriteViewController.swift
//  LodgingCommunity
//
//  Created by 박지현 on 2021/07/02.
//

import UIKit
import RxSwift
import RxCocoa

class FavoriteViewController: UITableViewController, FavoriteCellDelegate {
    let vm: FavoriteViewModel = FavoriteViewModel()
    let disposeBag = DisposeBag()
    let coordinator: DetailCoordinator = DetailCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = nil
        tableView.dataSource = nil
        
        bindOutlet()
    }
    
    func bindOutlet() {
        vm.pagingData.bind(to: (self.tableView.rx.items(cellIdentifier: "LodgingCell", cellType: FavoriteCell.self))) { (row, element, cell) in
            cell.update(pro: element)
            cell.cellDelegate = self
        }.disposed(by: disposeBag)
        
        Observable
            .zip(tableView.rx.modelSelected(Product.self), tableView.rx.itemSelected)
            .bind { [weak self] (product, indexPath) in
                self?.coordinator.pushToDetail(self?.navigationController, pro: product, id: indexPath.row)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.didEndDecelerating
            .subscribe(onNext: {
                if (self.tableView.contentOffset.y + 1) >= (self.tableView.contentSize.height - self.tableView.frame.size.height) {
                    self.vm.paging(isRefresh: false)
                }
            }).disposed(by: disposeBag)
        
        vm.alertMsg.subscribe(onNext: { msg in
            let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
            var okAction : UIAlertAction
            okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
        }).disposed(by: disposeBag)
    }
    
    func didTapFavorite(cell: FavoriteCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let imageName = vm.tapFavorite(cnt: indexPath.item) ? "heart.fill" : "heart"
            cell.favorite.setImage(UIImage(systemName: imageName), for: .normal)
            
        }
    }
    
}
