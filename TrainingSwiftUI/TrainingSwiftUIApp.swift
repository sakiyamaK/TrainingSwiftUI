//
//  TrainingSwiftUIApp.swift
//  TrainingSwiftUI
//
//  Created by sakiyamaK on 2025/07/27.
//

import SwiftUI
import TrainingBasic
import TrainingTCA
import WWDC

@main
struct TrainingSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            CustomLayout(pets: .constant(Pet.exampleData))
        }
    }
}
