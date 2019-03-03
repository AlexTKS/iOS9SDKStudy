//
//  AlexAboutWebViewController.swift
//  iOS9SDKStudy
//
//  Created by Александр on 05.11.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import UIKit

class AlexWKWebView: WKWebViev {

   override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		if let url = URL(string: "http://adobe.com") {
			let request = URLRequest(url: url)
			webView.loadRequest(request)
		}
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
