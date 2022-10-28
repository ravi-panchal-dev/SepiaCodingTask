//
//  PetListTableViewCell.swift
//  Sepia Test
//
//  Created by iOS on 28/10/22.
//

import UIKit

class PetListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewContainer        : UIView!
    @IBOutlet weak var imgPet               : ImageViewWithCache!
    @IBOutlet weak var stackViewPetDetails  : UIStackView!
    @IBOutlet weak var lblPetName           : UILabel!
    @IBOutlet weak var lblDetailURL         : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgPet.layer.cornerRadius = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension PetListTableViewCell {
    func setupModelData(petData:PetModel) {
        self.lblPetName?.text = petData.title
        self.lblDetailURL?.text = "Wiki Details :- \(petData.wikiURL ?? "")"
        self.imgPet?.loadImageWithUrl(URL(string: petData.imgURL!)!)
    }
}



//MARK: To Load Image Locally When APP is Memory

let imageCache = NSCache<AnyObject, AnyObject>()

class ImageViewWithCache: UIImageView {

    var imgURL: URL?

    let activityIndicator = UIActivityIndicatorView()

    func loadImageWithUrl(_ url: URL) {
        
        image = nil
        activityIndicator.color = .black
        addSubview(activityIndicator)
    
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imgURL = url
        
        activityIndicator.startAnimating()
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            activityIndicator.stopAnimating()
        }else{
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error as Any)
                    DispatchQueue.main.async(execute: {
                        self.activityIndicator.stopAnimating()
                    })
                    return
                }
                
                DispatchQueue.main.async(execute: {
                    if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                        if self.imgURL == url {
                            self.image = imageToCache
                        }
                        imageCache.setObject(imageToCache, forKey: url as AnyObject)
                    }
                    self.activityIndicator.stopAnimating()
                })
            }).resume()
            
        }
    }
    
    
}
