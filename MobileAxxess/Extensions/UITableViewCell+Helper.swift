//
//  UITableViewCell+Helper.swift
//  MobileAxxess
//
//  Created by Pratik Sodha on 30/08/20.
//  Copyright © 2020 Pratik Sodha. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {

    static var reuseIdentifier : String{
        return String(describing: self)
    }

}
