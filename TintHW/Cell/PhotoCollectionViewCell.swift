//
//  PhotoCollectionViewCell.swift
//  TintHW
//
//  Created by Ting on 2024/3/30.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    static let identifier = "PhotoCollectionViewCell"
    
    override var reuseIdentifier: String? {
        return PhotoCollectionViewCell.identifier
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = .red
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        contentLabel.text = nil
        imageView.image = nil
    }

    func configuration(model: PhotosCellModel) {
        self.titleLabel.text = model.id
        self.contentLabel.text = model.title
        //self.imageView.image = model.thumbnailUrl
    }
}
