//
//  KCPersistenKeyChain.swift
//  KCHerosSwiftUI
//
//  Created by Kary Rguez on 21/12/24.
//

import Foundation

@propertyWrapper

class KCPersistenKeyChain {
    private var key:String
    
    init(key: String) {
        self.key = key
    }
    
    var wrappedValue: String {
        get{
            return KeyChainKC().loadKC(key: self.key)
        }
        
        set{
            KeyChainKC().saveKC(key: self.key, value: newValue)
        }
    }
}
