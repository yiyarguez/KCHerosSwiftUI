//
//  LoginRepositoryProtocol.swift
//  KCHerosSwiftUI
//
//  Created by Kary Rguez on 21/12/24.
//

import Foundation

protocol LoginrepositoryProtocol {
    func loginApp(user: String, password: String) async -> String
}

