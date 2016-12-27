//
//  DBManager.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 02.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import RealmSwift

private let _sharedInstance = DBManager()
class DBManager {
    
    class var shared : DBManager {
        return _sharedInstance
    }
    
    let schemaVersion: UInt64 = 4
    
    func cacheObject(_ object:Object) { 
        let  configuration = Realm.Configuration(encryptionKey: self.getKey(), schemaVersion: schemaVersion)
        let realm = try! Realm(configuration: configuration)
        try! realm.write {
            realm.add(object)
            print("Записали в Базу")
        }
    }
    
    func addLinkToProfile (profile: RealmProfile, link : RealmLink) {
        let  configuration = Realm.Configuration(encryptionKey: self.getKey(), schemaVersion: schemaVersion)
        let realm = try! Realm(configuration: configuration)
        try! realm.write {
            profile.links.append(link)
        }
    }
    
    func addProfileToUser(user : RealmUser, profile: RealmProfile) {
        let  configuration = Realm.Configuration(encryptionKey: self.getKey(), schemaVersion: schemaVersion)
        let realm = try! Realm(configuration: configuration)
        try! realm.write {
            user.profiles.append(profile)
        }
    }
    
    func loadUserFromCache() -> RealmUser? {
        let  configuration = Realm.Configuration(encryptionKey: self.getKey(), schemaVersion: schemaVersion)
        let realm = try! Realm(configuration: configuration)
        let savedDB = realm.objects(RealmUser.self)
        if savedDB.count > 0 {
            for loadUser in savedDB {
                if loadUser.isAuth == true {
                    return loadUser
                }
            }
        }
        return nil
    }
    
    func cleanDB() {
        autoreleasepool {
            let configuration = Realm.Configuration(encryptionKey: self.getKey(), schemaVersion: schemaVersion) //realm
            let  realm = try! Realm(configuration: configuration)
            // Add an object
            try! realm.write {
                realm.deleteAll()
            }
        }
        
    }
    
}



extension DBManager {
    
    fileprivate func getKey() -> Data {
        let keychainIdentifier = "kuznetsov.realmKey"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
        
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as! Data
        }
        
        var keyData = Data(count: 64)
        
        let result = keyData.withUnsafeMutableBytes { bytes in
            SecRandomCopyBytes(kSecRandomDefault, 64, bytes)
        }
        
        assert(result == 0, "Failed to get random bytes")
        
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: "512" as NSString,
            kSecValueData: NSMutableData(data:keyData)
        ]
        
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
        
        return keyData as Data
        
    }
    
    fileprivate func getNextId(_ object: Object.Type) -> Int {
        let  configuration = Realm.Configuration(encryptionKey: self.getKey(), schemaVersion: schemaVersion)
        let realm = try! Realm(configuration: configuration)
        let getNext = realm.objects(object).sorted(byProperty: "id").last
        if getNext != nil {
            let valor = getNext!.value(forKey: "id") as? Int
            return valor! + 1
        } else {
            return 1
        }
    }
}

