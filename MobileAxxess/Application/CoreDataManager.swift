//
//  CoreDataManager.swift
//  MobileAxxess
//
//  Created by Pratik Sodha on 30/08/20.
//  Copyright © 2020 Pratik Sodha. All rights reserved.
//

import Foundation
import CoreStore

class CoreDataManager {

    static var manager : CoreDataManager = CoreDataManager()

    typealias SetupCoreDataCompletion = (_ completed: Bool)->()
    
    func setupCoreData(completion: @escaping CoreDataManager.SetupCoreDataCompletion){
        
        let dataStack = DataStack(
            xcodeModelName: "MobileAxxess",
            migrationChain: ["MobileAxxess"]
        )
        CoreStoreDefaults.dataStack = dataStack

        _ = dataStack.addStorage(
        SQLiteStore(fileName: "MobileAxxess.sqlite")) { (result) in
//            print("result.isSuccess := \(result)")
            OperationQueue.main.addOperation({
                completion(true)
            })
        }
    }

}
