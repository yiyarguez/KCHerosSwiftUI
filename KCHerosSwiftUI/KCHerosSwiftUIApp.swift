//
//  KCHerosSwiftUIApp.swift
//  KCHerosSwiftUI
//
//  Created by Kary Rguez on 20/12/24.
//

import SwiftUI


@main
struct KCHerosSwiftUIApp: App {
   
    @State var AppState = AppStateVM() //viewModel global
    

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(AppState) //Inyectamos el app state en el environment
        }
    }
}
