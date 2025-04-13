//
//  ImageViewModel.swift
//  Assignment_iOS
//
//  Created by apple on 10/04/25.
//

import Foundation
import UIKit

class ImageViewModel {
    
    var selectedImage: ((UIImage?) -> Void)?

    func handleImageSelection(image: UIImage?) {
        selectedImage?(image)
    }
}
