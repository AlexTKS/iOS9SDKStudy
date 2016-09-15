//
//  AlexDetailCell.swift
//  FirstTV
//
//  Created by Александр on 27.06.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import UIKit

class AlexDetailCell: UITableViewCell {

    @IBOutlet weak var pName: UILabel!
    @IBOutlet weak var pValue: UILabel!
    
    func SetCell(pNameL:String, pValueL:String) -> Void
    {
        self.pName.text = pNameL
        self.pValue.text = pValueL
    }
    
}
