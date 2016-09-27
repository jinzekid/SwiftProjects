//
//  CIMainViewController.swift
//  CoreImageSwift
//
//  Created by YangLu on 16/2/4.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import UIKit

class CIMainViewController: UIViewController, UIActionSheetDelegate , UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // MARK: - IBOutlest
    @IBOutlet weak var videoButton: BasicButton!
    @IBOutlet weak var albumButton: BasicButton!
    
    // MARK: - Lifecycle
    #if swift(>=2.3)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    #else
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    #endif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        initSwipGesture()
        self.hiddenNavigationBar(true)
        self.initButtonAction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UIImagepicker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        print("mediaType==\(mediaType)")
        
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        print("img size:\(img.size)")
        #if swift(>=2.3)
            let croppedRect = info[UIImagePickerControllerCropRect]?.cgRectValue()
        #else
            let croppedRect = info[UIImagePickerControllerCropRect]?.CGRectValue()
        #endif
        print("crop rect :\(croppedRect)")
        
        let editorImage = info[UIImagePickerControllerEditedImage] as! UIImage
        print("editorImage size:\(editorImage.size)")
        
        originImage = cropped(img, in: croppedRect!)
        #if swift(>=2.3)
        picker.dismiss(animated: true) {
            pushVCByXibWithName(name: "CIEditorViewController")
        }
        #else
            picker.dismissViewControllerAnimated(true, completion: { 
                pushVCByXibWithName(name: "CIEditorViewController")
            })
        #endif
    }
    
    // MARK: - Utility Methods
    func initButtonAction() {
        self.albumButton.initButtonHandler { 
            self.openMediaFromSource(.savedPhotosAlbum)
        }
        
        self.videoButton.initButtonHandler { 
            self.openMediaFromSource(.camera)
        }
    }
    
    // MARK: -手势判断
//    func handleRightSwipeGesture(_ sender: UISwipeGestureRecognizer) {
//        // 打开相册
////        openMediaFromSource(.SavedPhotosAlbum)
//        openAssetsGroupController()
//    }
//    func handleLeftSwipeGesture(_ sender: UISwipeGestureRecognizer) {
//        // 打开相机
//        openMediaFromSource(.Camera)
//    }
    
    //MARK: -根据类型打开媒体库
    #if swift(>=2.3)
    func openMediaFromSource(_ sourceType: UIImagePickerControllerSourceType) {
        
        let mediaTypes = UIImagePickerController.availableMediaTypes(for: sourceType)
        if UIImagePickerController.isSourceTypeAvailable(sourceType) && mediaTypes?.count > 0 {
            let imagePicker = UIImagePickerController.init()
            imagePicker.mediaTypes = mediaTypes!
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourceType
            self.present(imagePicker, animated: true, completion: { () -> Void in
                print("open camera!")
            })
        }
    }
    #else
    func openMediaFromSource(sourceType: UIImagePickerControllerSourceType) {
        
        let mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(sourceType)
        if UIImagePickerController.isSourceTypeAvailable(sourceType) && mediaTypes?.count > 0 {
            let imagePicker = UIImagePickerController.init()
            imagePicker.mediaTypes = mediaTypes!
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourceType
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    #endif
    
    func openAssetsGroupController() {
        presentVCByXibWithName("CIAssetsListViewController")
    }
    
//    func createSwipImageAnimationToAblum() {
//        let image = UIImage(named: "swipeRight")
//        let swipeRightImageView = UIImageView.init(image: image)
//        let swipeRightSize = swipeRightImageView.bounds.size
//        
//        let rect = self.albumImageView.frame
//        let swipeRightRect = CGRectMake(rect.origin.x, rect.origin.y, swipeRightSize.width, swipeRightSize.height)
//        swipeRightImageView.frame = swipeRightRect
//        self.view.addSubview(swipeRightImageView)
//    }
    
//    @IBAction func imageSelectAction(sender: AnyObject) {
//        let actionSheet: UIActionSheet
//        let isSupportCamera = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
//        if isSupportCamera {
//            actionSheet = UIActionSheet.init(title: "选择图片", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "相册", "相机")
//        }
//        else {
//            actionSheet = UIActionSheet.init(title: "选择图片", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "相册")
//        }
//        actionSheet.showInView(self.view)
//    }
}
