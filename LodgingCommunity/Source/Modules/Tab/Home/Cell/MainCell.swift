//
//  MainCell.swift
//  LodgingCommunity
//
//  Created by 박지현 on 2021/07/02.
//

import Foundation
import UIKit

protocol MainCellDelegate: AnyObject {
    func didTapFavorite(cell: MainCell)
}

class MainCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var favorite: UIButton!
    
    weak var cellDelegate: MainCellDelegate?
    
    @IBAction func SelectFavorite(_ sender: Any) {
        cellDelegate?.didTapFavorite(cell: self)
    }
    
    func update(pro: Product) {
        name.text = pro.name
        rateLabel.text = "\(pro.rate)"
        var imageName = "heart.fill"
        if UserDefaults.standard.string(forKey: "\(pro.id)") == nil {
            imageName = "heart"
        }
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
