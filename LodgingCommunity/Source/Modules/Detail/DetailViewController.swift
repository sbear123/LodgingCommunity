//
//  DetailViewController.swift
//  LodgingCommunity
//
//  Created by 박지현 on 2021/07/03.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var favorite: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var subject: UILabel!
    
    let vm: DetailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoad()
    }
    
    @IBAction func Favorite(_ sender: Any) {
        let imageName = vm.pushFavorite() ? "heart.fill" : "heart"
        favorite.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func viewLoad() {
        let pro = vm.pro
        name.text = pro.name
        rate.text = "\(pro.rate)"
        price.text = "가격 : \(pro.description.price)원"
        subject.text = pro.description.subject
        let imageName = pro.favorite ? "heart.fill" : "heart"
        favorite.setImage(UIImage(systemName: imageName), for: .normal)
        URLSession.shared.dataTask(with: URL(string: pro.description.imagePath)!) { (data, response, err) in
            if let data = data {
                DispatchQueue.main.async {
                    self.transition(toImage: UIImage(data: data))
                }
            }
        }.resume()
    }
    
    func transition(toImage image: UIImage?) {
        UIView.transition(with: img, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.img.image = image
                          },
                          completion: nil)
    }
    
}
