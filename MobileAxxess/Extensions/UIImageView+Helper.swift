//
//  UIImageView+Helper.swift
//  MobileAxxess
//
//  Created by Pratik Sodha on 30/08/20.
//  Copyright © 2020 Pratik Sodha. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
 
    func set(with urlString: String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        self.kf.indicatorType = .activity
        (self.kf.indicator?.view as? UIActivityIndicatorView)?.color = .red
        self.kf.setImage(with: resource)
    }
}
