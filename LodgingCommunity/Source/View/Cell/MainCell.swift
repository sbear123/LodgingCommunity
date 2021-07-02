//
//  MainCell.swift
//  LodgingCommunity
//
//  Created by 박지현 on 2021/07/02.
//

import Foundation
import UIKit
import Cosmos

class MainCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var favorite: UIButton!
    
    func update(pro: Product) {
        name.text = pro.name
        rateView.rating = pro.rate
        rateView.text = "\(pro.rate)"
        let imageName = pro.favorite.isFavorite ? "heart.fill" : "heart"
        favorite.setImage(UIImage(systemName: imageName), for: .normal)
        URLSession.shared.dataTask(with: URL(string: pro.thumbnail)!) { (data, response, err) in
            if let data = data {
                DispatchQueue.main.async {
                    self.transition(toImage: UIImage(data: data))
                }
            }
        }.resume()
    }
    
    func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.thumbnail.image = image
                          },
                          completion: nil)
    }
}
