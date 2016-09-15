//
//  AlexRateController.swift
//  iOS9SDKStudy
//
//  Created by Александр on 15.09.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import UIKit

class AlexRateController: UIViewController {

	
	@IBOutlet weak var RestImage: UIImageView!
	var ImageName: String = ""
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		RestImage.image = UIImage(named: ImageName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
