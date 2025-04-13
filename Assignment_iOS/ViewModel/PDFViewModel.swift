//
//  PDFViewModel.swift
//  Assignment_iOS
//
//  Created by apple on 10/04/25.
//

import Foundation

class PDFViewModel {
    func fetchPDF(from urlString: String, completion: @escaping (URL?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.downloadTask(with: url) { localURL, _, _ in
            completion(localURL)
        }.resume()
    }
}
