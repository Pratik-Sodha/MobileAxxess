//
//  RawDataCDM+Helper.swift
//  MobileAxxess
//
//  Created by Pratik Sodha on 30/08/20.
//  Copyright © 2020 Pratik Sodha. All rights reserved.
//

import Foundation
import CoreStore

extension RawDataCDM {
    
}

//---------------------------------------------------------
//MARK:-
extension RawDataCDM {
    static var allRecords : [RawDataCDM]  {
        var records : [RawDataCDM] = []
        do {
            records = try CoreStoreDefaults.dataStack.fetchAll(From<RawDataCDM>().tweak( {$0.includesPendingChanges = false }))
        }catch {
            print(":: == ❌ \(error) ❌ == ::")
        }
        return records
    }
}

//---------------------------------------------------------
//MARK:-
extension RawDataCDM {
    
    private func itteration(source : RawDataDM) {
        id = source.id
        type = source.type
        data = source.data
        date = source.date
    }
}

//---------------------------------------------------------
//MARK:- ImportableUniqueObject
extension RawDataCDM : ImportableUniqueObject {
    
    public typealias ImportSource = RawDataDM

    public typealias UniqueIDType = String

    public static var uniqueIDKeyPath: String {
        return #keyPath(RawDataCDM.id)
    }
    
    public static func uniqueID(from source: RawDataDM, in transaction: BaseDataTransaction) throws -> String? {
        return source.id
    }
    
    public func update(from source: RawDataDM, in transaction: BaseDataTransaction) throws {
        itteration(source: source)
    }



    public func didInsert(from source: RawDataDM, in transaction: BaseDataTransaction) throws {
        itteration(source: source)
    }

    typealias ImportLayoutDataCompletion = (_ success: Bool, _ error : NSError?)->()
    static func importMasterData(records : [RawDataDM], completion : ImportLayoutDataCompletion? = nil) {

        let sourceArray : [RawDataCDM.ImportSource] = records
        CoreStoreDefaults.dataStack.perform(asynchronous: { (transaction) -> Void in

            let _ = try transaction.importUniqueObjects(
                Into<RawDataCDM>(),
                sourceArray: sourceArray
            )

        }) { (result) in
         
            switch result {
            case .success(_):
                completion?(true, nil)
                break
            case let .failure(error):
                completion?(false, error as NSError)
                break
            }}
    }
    
}

//---------------------------------------------------------
//MARK:-
extension Array where Element : RawDataCDM {
    var rawDataArrayValue : [RawDataDM] {
        map{RawDataDM(rawCDM: $0)}
    }
}
