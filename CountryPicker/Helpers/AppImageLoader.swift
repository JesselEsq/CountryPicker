//
//  AppImageLoader.swift
//  CountryPicker
//
//  Created by Jessel Esquinas on 1/13/22.
//

import Foundation
import Kingfisher

public typealias ImageLoaderCompletion = ((Result<UIImage, Error>) -> Void)

class AppImageLoader {
    // MARK: - ImageLoader
    
    func loadImage(for imageView: UIImageView,
                   with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: resource,
                              placeholder: nil,
                              completionHandler: nil)
    }
}

