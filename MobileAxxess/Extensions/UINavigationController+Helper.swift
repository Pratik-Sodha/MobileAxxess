//
//  UINavigationController+Helper.swift
//  MobileAxxess
//
//  Created by Pratik Sodha on 30/08/20.
//  Copyright © 2020 Pratik Sodha. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {

    /**
     Configure navigation controller as per require.
     Like change UIBarButtonItem appearance, shadowImage, tintColor, barTintColor, navigationtitle attributes.
     */
    convenience init(mobileAxxessNavigationBarController controller : UIViewController) {
        self.init(rootViewController: controller)
    }

    
}
