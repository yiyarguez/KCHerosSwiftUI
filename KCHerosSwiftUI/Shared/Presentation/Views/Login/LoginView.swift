//
//  LoginView.swift
//  KCHerosSwiftUI
//
//  Created by Kary Rguez on 20/12/24.
//

import SwiftUI

struct LoginView: View {
    
#if DEBUG
    @State private var email = "kary@gmail.com"
    @State private var password = "1234"
    
#else
    @State private var email = ""
    @State private var password = ""
#endif
    
    @State private var animationAmount = 1.0
    
    // appState instanciado en el environment y lo asigna aquí
    @Environment(AppStateVM.self) var appState
    
    var body: some View {
        
        ZStack {
            Image(.backgroundLogin)
                .resizable()
            Image(decorative: "")
                .resizable()
                .background()
                .opacity(0.1)
            
            //Componentes
            VStack {
                Image(.title)
                    .resizable()
                    .scaledToFit()
                    .opacity(0.8)
                    .padding(.top, 100)
                    .padding([.leading, .trailing], 20)
                Spacer()
                
                //Usuario y Password
                VStack {
                    TextField("Email", text: $email)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.blue)
                        .cornerRadius(20)
                        .font(.headline)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .shadow(radius: 10, x:0, y:10)
                        .id(1) // UI Testing
                    
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.blue)
                        .cornerRadius(20)
                        .font(.headline)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .shadow(radius: 10, x:0, y:10)
                        .padding(.top, 15)
                        .id(2) // UI Testing
                }
                .padding([.trailing, .leading], 30)
                
                //Botón
                Button {
                    //Login to Server
                    appState.loginApp(user: email, pass: password)
                    
                } label: {
                    Text("Entrar")
                        .font(.title)
                        .frame(width: 300, height: 50)
                        .foregroundStyle(.white)
                        .background(Color.orange)
                        .cornerRadius(15)
                        .shadow(radius: 10, x:20, y:10)
                }
                .padding(.top, 50)
                .opacity(0.8)
                .id(3) // UI Testing
                
                //Animación del botón
                .overlay(
                    Circle()
                        .stroke(.white)
                        .scaleEffect(animationAmount)
                        .opacity(2 - animationAmount)
                        .animation(
                            .easeInOut(duration: 1).repeatForever(autoreverses: false), value: animationAmount
                        )
                        .padding(.top, 50)
                )
                .onAppear {
                    animationAmount = 2
                }
                
                Spacer()
                
                HStack {
                    Text("¿No tienes cuenta?")
                        .foregroundStyle(.white)
                        .bold()
                    Button {
                        //Action here
                    } label: {
                        Text("Registro")
                            .foregroundStyle(.blue)
                    }
                    
                    
                }
                .padding(.bottom, 20)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LoginView()
        .environment(AppStateVM())
        .preferredColorScheme(.light)
        .environment(\.locale, .init(identifier: "es"))
}
