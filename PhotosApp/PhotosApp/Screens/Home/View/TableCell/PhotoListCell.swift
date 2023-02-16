//
//  PhotoListCell.swift
//  PhotosApp
//
//  Created by Rajeswaran Thangaperumal on 16/02/23.
//

import UIKit

class PhotoListCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var viewModel: PhotoCellViewModel? {
        didSet {
            self.nameLabel.text = viewModel?.photoName
            self.photoImageView.load(urlString: viewModel?.photoThumUrl ?? "" )
        }
    }
    
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.photoImageView.layer.cornerRadius = 5.0
    }
    
}
