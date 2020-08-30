//
//  Router.swift
//  MobileAxxess
//
//  Created by Pratik Sodha on 30/08/20.
//  Copyright © 2020 Pratik Sodha. All rights reserved.
//

import Foundation
import UIKit
class Router {
    
    static var shared: Router = Router()
    
    weak var window: UIWindow!
    
    func showRawDataList(in window: UIWindow?) {

        guard let window = window else {
            print("<\(self) : Window not found>")
            return
        }

        window.makeKeyAndVisible()
        let rootNavigation = UINavigationController(mobileAxxessNavigationBarController: RawDataListController.loadController())
        window.rootViewController = rootNavigation
        self.window = window
    }
}

//---------------------------------------------------------
//MARK:-
extension Router : CustomDebugStringConvertible {
    var debugDescription: String {
        return "Router"
    }
}
