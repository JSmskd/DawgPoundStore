//
//  Extension.swift
//  DawgPoundStore
//
//  Created by John Sencion on 5/20/25.
//

import CloudKit
import SwiftUI
extension CKRecord {
    func GCKV(_ key:CKRecord.FieldKey) -> (any __CKRecordObjCValue)? {
        self.object(forKey: key)
    }
    ///setCloudKitValue
    func SCKV(_ key:CKRecord.FieldKey, _ value:(any __CKRecordObjCValue)) {
        self.setObject(value, forKey: key)
    }
}
///all of the classes/structs should have this
protocol JSRecord:Identifiable, Hashable, Equatable {
    var id:CKRecord.ID { get }
    var record:CKRecord { get set }
}

extension JSRecord {
    var id:CKRecord.ID { get {
        return record.recordID
    } }
}
