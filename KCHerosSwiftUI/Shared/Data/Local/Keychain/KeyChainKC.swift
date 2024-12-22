//
//  KeyChainKC.swift
//  KCHerosSwiftUI
//
//  Created by Kary Rguez on 21/12/24.
//

import Foundation
import KeychainSwift

public struct KeyChainKC {
    public init() {
        
    }
    
    //Guardar una clave
    @discardableResult
    public func saveKC(key: String, value: String) -> Bool {
         if let data = value.data(using: .utf8) {
            let keychain = KeychainSwift()
            return keychain.set(data, forKey: key)
         } else {
             return false //Error desempaquetado
         }
    }
    
    //Cargar una clave
    public func loadKC(key: String) -> String {
        let keychain = KeychainSwift()
        if let data = keychain.get(key) {
            return data
        } else {
            return ""
        }
    }
    
    //Eliminar una clave
    @discardableResult
    public func deleteKC(key: String) -> Bool {
        return KeychainSwift().delete(key)
    }
}
