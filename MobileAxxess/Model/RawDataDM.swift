//
//  RawDataDM.swift
//  MobileAxxess
//
//  Created by Pratik Sodha on 30/08/20.
//  Copyright © 2020 Pratik Sodha. All rights reserved.
//

import Foundation
/*
{
  "id": "2639",
  "type": "image",
  "date": "9/4/2015",
  "data": "https://placeimg.com/620/320/any"
}
 */

enum RawDataType : String {
    case unknown
    case image
    case text
    case other

    var title : String {
        String(describing: self).capitalized
    }
}

open class RawDataDM : Codable {

    let id   : String
    let type : String
    let date : String?
    let data : String?
    
    init(rawCDM : RawDataCDM) {
        id = rawCDM.id ?? ""
        type = rawCDM.type ?? ""
        date = rawCDM.date
        data = rawCDM.data
    }

}
//---------------------------------------------------------
//MARK:-
extension RawDataDM {
    var rawType : RawDataType { RawDataType(rawValue: type) ?? .unknown }
}



extension RawDataDM : Hashable {
    /*
    FIXME: NOT UNIQUE ID

    In current JSON response there is not unique id. There is "0" two times. So right now generating hash value combing with type and id both.
    
    */

    public static func == (lhs: RawDataDM, rhs: RawDataDM) -> Bool {
        return (lhs.id == rhs.id && lhs.type == rhs.type)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(type)
    }
    
}
