//
//  AlexTableViewCell.swift
//  FirstTV
//
//  Created by Александр on 22.05.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import UIKit

class AlexTableViewCell: UITableViewCell {
    
	var restaurant:Restaurant!//.init(name: "", type: "", location: "", phoneNumber: "", image: "", isVisited: false)

    @IBOutlet weak var RestImage: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var `Type`: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
		
    }
	
	public func FillCell() {
		
		self.Name.text = restaurant.name
		self.Type.text = restaurant.type
		self.Location.text = restaurant.location
		if let restaurantImage = restaurant.image{
			self.RestImage.image = UIImage.init(data: restaurantImage)
		}
		
	}
	
}
