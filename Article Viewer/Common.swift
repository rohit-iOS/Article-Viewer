//
//  Common.swift
//  Article Viewer
//
//  Created by Rohit Karyappa on 13/07/2022.
//

import Foundation
import UIKit

enum TimeFrame: Int {
    case day = 1
    case week = 7
    case month = 30
}


class ImageStore: NSObject {
    static let imageCache = NSCache<NSString, UIImage>()
}

extension UIImageView {
    func loadFrom(urlString: String?) {
        DispatchQueue.global().async { [weak self] in
            guard let stringURL = urlString, let url = URL(string: stringURL) else {
                return
            }
            func setImage(image:UIImage?) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
            let urlToString = url.absoluteString as NSString
            if let cachedImage = ImageStore.imageCache.object(forKey: urlToString) {
                setImage(image: cachedImage)
            } else if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageStore.imageCache.setObject(image, forKey: urlToString)
                    setImage(image: image)
                }
            }else {
                setImage(image: nil)
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
