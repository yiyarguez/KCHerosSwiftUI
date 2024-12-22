//
//  StatusModel.swift
//  KCHerosSwiftUI
//
//  Created by Kary Rguez on 21/12/24.
//

import Foundation

///Estados de la aplicación

enum Status {
    case none, loading, loaded, register, error(error: String)
}
