//
//  LoginUserCase.swift
//  KCHerosSwiftUI
//
//  Created by Kary Rguez on 21/12/24.
//

import Foundation

protocol LoginUserCaseProtocol {
    var repo: LoginrepositoryProtocol {get set}
    
    //Funciones
    func loginApp(user: String, password: String) async -> Bool
    func logout() async -> Void
    func validateToken() async -> Bool
    
}

final class LoginUserCase: LoginUserCaseProtocol {
    var repo: LoginrepositoryProtocol
    
    @KCPersistenKeyChain(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
    var tokenJWT
    
    init(repo: LoginrepositoryProtocol = DefaultLoginRepository()) {
        self.repo = repo
    }
    
    //Funciones
    func loginApp(user: String, password: String) async -> Bool {
        let token = await repo.loginApp(user: user, password: password)
        
        //Persistencia en el keychain
        if token != "" {
           // KeyChainKC().saveKC(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN, value: token)
            tokenJWT = token
            return true
        } else {
            //KeyChainKC().deleteKC(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
            tokenJWT = ""
            return false
        }
    }
    
    func logout() async {
        KeyChainKC().deleteKC(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
     //Validamos si existe el token y tiene la cadena rellena
     //Nota: los tokens tiene un tiempo de vida
        
      //  if KeyChainKC().loadKC(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN) != "" {
        if tokenJWT != "" {
            return true //Es valido
        } else {
            return false //No valido
        }
    }
}
