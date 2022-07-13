//
//  Common.swift
//  Article Viewer
//
//  Created by Rohit Karyappa on 13/07/2022.
//

import Foundation
import UIKit

extension UIImageView {
    func loadFrom(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}

extension String {
    func getDateFromString() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"

        if let date: Date = dateFormatterGet.date(from: self) as Date? {
            return dateFormatterPrint.string(from: date)
        }
        
        return "Unknown"
    }
}
