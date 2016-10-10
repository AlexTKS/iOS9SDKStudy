//
//  AlexAddRestViewController.swift
//  iOS9SDKStudy
//
//  Created by Александр on 18.09.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import UIKit
import Photos


class AlexAddRestViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet weak var AddingImage: UIImageView!
	@IBOutlet weak var iBeenHere: UISwitch!
	@IBOutlet weak var eName: UITextField!
	@IBOutlet weak var eType: UITextField!
	@IBOutlet weak var eLocation: UITextField!
	
	private let ImagePicker = UIImagePickerController()
	
	public var addRestorant:Restaurant!  
	public var RestoratAdded = false
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
		
		ImagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0{
			let selectInput = UIAlertController(title: "Загрузить фото из", message: "", preferredStyle: .actionSheet)
			let FromLibraryAction = UIAlertAction.init(title: "Из библиотеки", style: .default, handler: { (Action) in
				// Обработка загрузки из библотеки
				if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
					self.ImagePicker.allowsEditing = false
					self.ImagePicker.sourceType = .photoLibrary
					self.present(self.ImagePicker, animated: true, completion: nil)
			}
			})
			let FromCameraAction = UIAlertAction(title: "Из камеры", style: .default, handler: { (Action) in
				// Получение из камеры
				if UIImagePickerController.isSourceTypeAvailable(.camera) && UIImagePickerController.isCameraDeviceAvailable(.rear){
					self.ImagePicker.allowsEditing = false
					self.ImagePicker.sourceType = .camera
					self.ImagePicker.cameraDevice = .rear
					self.ImagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
					self.ImagePicker.cameraCaptureMode = .photo
					self.ImagePicker.cameraFlashMode = .auto
					self.ImagePicker.showsCameraControls = true
					self.present(self.ImagePicker, animated: true, completion: nil)
				}
			})
			let CancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
			selectInput.addAction(FromLibraryAction)
			selectInput.addAction(FromCameraAction)
			selectInput.addAction(CancelAction)
			present(selectInput, animated: true, completion: nil)
		}
	}
	
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		AddingImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
		AddingImage.contentMode = .scaleAspectFill
		AddingImage.clipsToBounds = true
		
		/*if picker.sourceType == .photoLibrary {
			//let metadata = info[UIImagePickerControllerMediaMetadata] as? NSDictionary
			let PHAsset = PHAssetChangeRequest.creationRequestForAsset(from: AddingImage.image!)
			let GPS = PHAsset.location
		}*/
		
		// Destructor
		dismiss(animated: true, completion: nil)
	}

	@IBAction func AddingRestorant(_ sender: AnyObject) {
		
		let name = eName.text
		let type = eType.text
		let location = eLocation.text
		
		if let restaurantImage = AddingImage.image {
			if let addRest = AddNewRestaurant(name: name!, type: type!, location: location!, phoneNumber: "", imageName: nil, imageData: UIImagePNGRepresentation(restaurantImage), isVisited: iBeenHere.isOn) {
				addRestorant = addRest
				addRestorant.FillRestaurant()
				RestoratAdded = true
				performSegue(withIdentifier: "UnwingeToRoot", sender: sender)
			}else{
				let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: UIAlertControllerStyle.alert)
				alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
				self.present(alertController, animated: true, completion: nil)
			}
		}
		
		
	}
    // MARK: - Table view data source

	/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
	*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	@IBAction func returnToAdd(segue: UIStoryboardSegue){
		
	}

}
