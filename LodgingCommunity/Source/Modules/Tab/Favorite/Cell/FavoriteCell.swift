//
//  FavoriteCell.swift
//  LodgingCommunity
//
//  Created by 박지현 on 2021/07/02.
//

import UIKit

protocol FavoriteCellDelegate: AnyObject {
    func didTapFavorite(cell: FavoriteCell)
}

class FavoriteCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var favorite: UIButton!
    @IBOutlet weak var selectTime: UILabel!
    
    weak var cellDelegate: FavoriteCellDelegate?
    
    @IBAction func SelectFavorite(_ sender: Any) {
        cellDelegate?.didTapFavorite(cell: self)
    }
    
    func update(pro: Product) {
        name.text = pro.name
        rateLabel.text = "\(pro.rate)"
        if UserDefaults.standard.string(forKey: "\(pro.id)") == nil {
            selectTime.text = ""
            favorite.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        else {
            selectTime.text = UserDefaults.standard.string(forKey: "\(pro.id)")
            favorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
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
