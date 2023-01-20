//
//  User.swift
//  RxSpace
//
//  Created by Aishwarya Aneja on 1/20/23.
//

import Foundation

import UIKit

final class UserDetail{
    private enum DataKey: String{
        case token
    }
    
    static var token :String{
        get{
            return UserDefaults.standard.string(forKey: DataKey.token.rawValue) ?? ""
        }
        set{
            let defaults = UserDefaults.standard
            let key = DataKey.token.rawValue
            defaults.setValue(newValue, forKey: key)
            defaults.synchronize()
        }
    }
    
}
