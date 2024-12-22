//
//  RootView.swift
//  KCHerosSwiftUI
//
//  Created by Kary Rguez on 21/12/24.
//

import SwiftUI

struct RootView: View {
    @Environment(AppStateVM.self) var appState
    
    var body: some View {
        
        switch(appState.status) {
        case .none:
            LoginView()
        case .loaded:
            Text("Home")
        case .loading:
            Text("Loading...")
        case .register:
            Text("Registro de usuario nuevo")
        case .error(error: let errorString):
            Text("Error: \(errorString)")
        }
    }
}

#Preview {
    RootView()
        .environment(AppStateVM())
}
