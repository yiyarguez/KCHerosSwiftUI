//
//  NetworkLogin.swift
//  KCHerosSwiftUI
//
//  Created by Kary Rguez on 21/12/24.
//

import Foundation

//Protocolo (ideal en fichero fuera en carpeta de protocolos de Network)
protocol NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String
}

final class NetworkLogin: NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String {
        var tokenJWT = ""
        
        //Declarar la llamada
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(Endpoints.login.rawValue)"
        let encodeCredentials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        var segCredential = ""
        
        //Desempaquetar
        if let credentials = encodeCredentials {
            segCredential = "Basic \(credentials)"
        }
        
        //Creamos el request
        var request: URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HttpMethods.post
        
        //Headers de request
        request.addValue(HttpMethods.content, forHTTPHeaderField: HttpMethods.contentTypeID)
        request.addValue(segCredential, forHTTPHeaderField: "Authorization")
        
        //Call to server
        do {
           let (data,response) = try await URLSession.shared.data(for: request)
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HttpResponseCodes.SUCCESS {
                    tokenJWT = String(decoding: data, as: UTF8.self)
                }
            }
            
        } catch {
            tokenJWT = ""
        }
        
        
        //Ejecutar la llamada
        
        return tokenJWT
    }
}

//Mock Success
final class NetworkLoginMock: NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String {
        return UUID().uuidString
    }
}
