//
//  UserDefaults.swift
//  SeSAC-SLP
//
//  Created by Sehun Kang on 2022/01/20.
//

import Foundation
import SwiftUI


@propertyWrapper
struct UserDefault<T> {
    
    private let key: String
    private let defaultValue: T
    private let storage: UserDefaults
    
    var wrappedValue: T {
        get { self.storage.object(forKey: self.key) as? T ?? self.defaultValue}
        set { self.storage.set(newValue, forKey: self.key)}
    }
    
    init(key: String, defaultValue: T, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
}

@propertyWrapper
struct UserDefaultStruct<T: Codable> {
    
    private let key: String
    private let defaultValue: T?
    
    var wrappedValue: T? {
        get {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let object = try? decoder.decode(T.self, from: savedData) {
                    return object
                }
            }
            return defaultValue
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.setValue(encoded, forKey: key)
            }
        }
    }
    
    init(key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
}

class UserDefaultManager {
    
    @UserDefault(key: "phoneNumber", defaultValue: "")
    static var phoneNumber: String
    
    @UserDefault(key: "FCMtoken", defaultValue: "")
    static var FCMtoken: String
    
    @UserDefault(key: "nick", defaultValue: "")
    static var nick: String
    
    @UserDefault(key: "birth", defaultValue: Date())
    static var birth: Date
    
    @UserDefault(key: "email", defaultValue: "")
    static var email: String
    
    @UserDefault(key: "gender", defaultValue: 2)
    static var gender: Int
    
    @UserDefault(key: "verifyToken", defaultValue: "")
    static var verifyId: String
    
    @UserDefault(key: "idtoken", defaultValue: "")
    static var idtoken: String
    
    ///1일 경우 invalid
    @UserDefault(key: "validNickFlag", defaultValue: 0)
    static var validNickFlag: Int
    
    @UserDefaultStruct(key: "userData", defaultValue: nil)
    static var userData: UserData?
    
    @UserDefaultStruct(key: "signInData", defaultValue: nil)
    static var signInData: SignInData?
}
