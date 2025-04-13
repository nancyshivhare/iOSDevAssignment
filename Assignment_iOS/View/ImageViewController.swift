//
//  ImageViewController.swift
//  Assignment_iOS
//
//  Created by apple on 10/04/25.
//

import UIKit

class ImageViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var uploadImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyDynamicColors()
        self.navigationController?.isNavigationBarHidden = true
        applyDynamicColors()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ThemeManager.applyTheme(ThemeManager.currentTheme)
    }
    
    @IBAction func btnuploadimg(_ sender: UIButton) {
        let alert = UIAlertController(title: "Upload Image", message: "Choose an option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        } else {
            showAlert(title: "Camera not available", message: "You can use gallery instead.")
        }
    }
    
    func openGallery() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    // Image Picker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let editedImage = info[.editedImage] as? UIImage {
            imgview.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            imgview.image = originalImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }
    
    
    
    @IBAction func btnback(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnshare(_ sender: UIButton) {
        guard let image = imgview.image else {
            showAlert(title: "No Image", message: "Please select or capture an image first.")
            return
        }
        
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = sender
        
        present(activityVC, animated: true, completion: nil)
    }
    
    private func applyDynamicColors() {
        view.backgroundColor = UIColor.systemBackground
        baseView.backgroundColor = UIColor.secondarySystemBackground
        backButton.tintColor = UIColor.label
        shareButton.tintColor = UIColor.label
        uploadImageButton.tintColor = UIColor.label
    }
    
}
