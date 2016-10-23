//
//  AlexTabBarController.swift
//  iOS9SDKStudy
//
//  Created by Александр on 23.10.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import UIKit

class AlexTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.delegate = self
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
		let VC = viewController as! UINavigationController
		if VC.topViewController is AlexUITableTableViewController {
			if VC.restorationIdentifier == "favorite" {
				(VC.topViewController as! AlexUITableTableViewController).favoriteController = true
			}
			(VC.topViewController as! AlexUITableTableViewController).updateSourceData(initial: false)
		}
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
