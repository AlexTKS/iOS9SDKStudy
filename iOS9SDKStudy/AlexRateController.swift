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
	@IBOutlet weak var RestName: UILabel!
	
	public var ImageName: String = ""
	public var RestoranName: String = ""
	
	public var rating: RestRating?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		RestImage.image = UIImage(named: ImageName)
		RestName.text   = RestoranName
		
		let BlurEffect = UIBlurEffect.init(style: .dark)
		let BlurEffectView = UIVisualEffectView.init(effect: BlurEffect)
		BlurEffectView.frame = view.bounds
		RestImage.addSubview(BlurEffectView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	/*
	override func viewDidAppear(_ animated: Bool) {
		<#code#>
	}
*/
	
	
	@IBAction func SetRating(_ sender: UIButton) {
		switch sender.tag {
		case 1:  rating = .poor
		case 2:  rating = .good
		case 3:  rating = .great
		default: rating = .nRate
		}
		performSegue(withIdentifier: "UnwindToDetale", sender: sender)
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
