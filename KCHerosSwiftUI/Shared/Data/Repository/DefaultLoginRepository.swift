//
//  DefaultLoginRepository.swift
//  KCHerosSwiftUI
//
//  Created by Kary Rguez on 21/12/24.
//

import Foundation

//Real
final class DefaultLoginRepository: LoginrepositoryProtocol {
   
    private var Network: NetworkLoginProtocol
    
    init(network: NetworkLoginProtocol = NetworkLogin()) {
        self.Network = network
    }
    
    func loginApp(user: String, password: String) async -> String {
        return await Network.loginApp(user: user, password: password)
    }
}

//Mock
final class DefaultLoginRepositoryMock: LoginrepositoryProtocol {
   
    private var Network: NetworkLoginProtocol
    
    init(network: NetworkLoginProtocol = NetworkLoginMock()) {
        self.Network = network
    }
    
    func loginApp(user: String, password: String) async -> String {
        return await Network.loginApp(user: user, password: password)
    }
}
