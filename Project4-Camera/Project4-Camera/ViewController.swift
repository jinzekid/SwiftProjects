//
//  ViewController.swift
//  Project4-Camera
//
//  Created by apple on 6/8/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var bImageView: BasicImageView!
    @IBOutlet weak var bTakePhotoButton: BasicButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bImageView.initParameters(radius: 5.0)
        bTakePhotoButton.initParameters(bgColor: UIColor.blueColor(), textColor: UIColor.whiteColor(), buttonRadius: 5.0)
        bTakePhotoButton.initButtonHandler { 
            let bActionSheet = BasicActionSheet(title: "选取照片", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "照片库")
            bActionSheet.showInView(self.view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Utility Methods
    // MARK: - action sheet delegate
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            if isSupportCamera() {
                createImagePicker(.Camera)
            }
        }
        else if buttonIndex == 2 {
            createImagePicker(.PhotoLibrary)
        }
    }
    
    func createImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerCtrl = UIImagePickerController.init()
        imagePickerCtrl.delegate = self
        imagePickerCtrl.sourceType = sourceType
        
        presentViewController(imagePickerCtrl, animated: true, completion: {
            
        })
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true) { 
            
        }
        bImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
}

