//
//  NavigationTitleKey.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//

import Foundation
import SwiftUI

struct NavigationTitleKey: EnvironmentKey{
    static let defaultValue: String = "F1 News"
}

extension EnvironmentValues{
    var navigationTitle: String{
        get {self[NavigationTitleKey.self]}
        set {self[NavigationTitleKey.self] = newValue}
    }
}
