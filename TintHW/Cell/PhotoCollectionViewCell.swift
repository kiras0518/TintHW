//
//  PhotoCollectionViewCell.swift
//  TintHW
//
//  Created by Ting on 2024/3/30.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        contentLabel.text = nil
        imageView.image = nil
    }
    
    func configuration(model: PhotosCellModel, image: UIImage?) {
        self.titleLabel.text = model.id
        self.contentLabel.text = model.title
        if let image = image {
            self.imageView.image = image
        } else {
            self.imageView.image = UIImage(systemName: "circle.square")
        }
    }
}

