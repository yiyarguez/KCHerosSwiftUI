//
//  AppStateVM.swift
//  KCHerosSwiftUI
//
//  Created by Kary Rguez on 21/12/24.
//

import Foundation
import Combine

@Observable
final class AppStateVM {
    //Publicadas
    var status = Status.none
    var tokenJWT: String = ""
    
    //No publicadas
    @ObservationIgnored
    var isLogged: Bool = false
    
    //Dependencias
    private var loginUseCase: LoginUserCaseProtocol
    
    init(LoginUC: LoginUserCaseProtocol = LoginUserCase()) {
        self.loginUseCase = LoginUC
        
        //Autologin
        Task {
            await validateControlLogin()
        }
    }
    
    
    ///Funcionalidad
    @MainActor
    func loginApp(user: String, pass: String) {
        
        self.status = .loading //Indico que estoy cargando
        
        Task {
            if (await loginUseCase.loginApp(user: user, password: pass) == true) {
                //Login Success
                self.status =  .loaded
            } else {
                //Login Error
                self.status = .error(error: "Error con el usuario o contraseña")
            }
        }
    }
    
    //Close session app
    @MainActor
    func closeSessionUser() {
        Task {
            await loginUseCase.logout()
            self.status = .none //Se muestra el login
        }
    }
    
    //Validate token
    @MainActor
    func validateControlLogin() {
        Task {
            if (await loginUseCase.validateToken() == true) {
                self.status = .loaded //Redirige a Home
                NSLog("Login OK")
            } else {
                //No hay token en el keychain
                self.status = .none
                NSLog("Login Error")
            }
        }
    }
    
}
