//
//  AlexTableViewCell.swift
//  FirstTV
//
//  Created by Александр on 22.05.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import UIKit

class AlexTableViewCell: UITableViewCell {
    
    var restaurant = Restaurant.init(name: "", type: "", location: "", phoneNumber: "", image: "", isVisited: false)

    @IBOutlet weak var RestImage: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var `Type`: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fill() -> Void
    {
        self.Name.text = restaurant.Name
        self.Type.text = restaurant.Type
        self.Location.text = restaurant.Location
        self.RestImage.image = UIImage.init(named: restaurant.Image)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
