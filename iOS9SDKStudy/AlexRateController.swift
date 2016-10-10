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
	@IBOutlet weak var AllRateButtons: UIStackView!
	
	public var ImageData: Data!
	public var RestoranName: String = ""
	
	public var rating: RestRating?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		RestImage.image = UIImage(data: ImageData)
		RestName.text   = RestoranName
		
		let BlurEffect = UIBlurEffect.init(style: .dark)
		let BlurEffectView = UIVisualEffectView.init(effect: BlurEffect)
		BlurEffectView.frame = view.bounds
		RestImage.addSubview(BlurEffectView)
		
		let sizeFrom = CGAffineTransform(a: 0, b: 0, c: 0, d: 0, tx: 0, ty: 0)
		let possFrom = CGAffineTransform(translationX: 0, y: view.bounds.height)
		AllRateButtons.transform = sizeFrom.concatenating(possFrom)
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	override func viewDidAppear(_ animated: Bool) {
		UIView.animate(withDuration: 0.7, delay: 0, options: [], animations: {
			self.AllRateButtons.transform = CGAffineTransform.identity
			}, completion: nil)
	}

	
	
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
