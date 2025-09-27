//
//  EnvironmentValues+.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/09/24.
//

import SwiftUI

//extension EnvironmentValues {
//    @MainActor @Entry var dataModel = DataModel()
//}

@MainActor
private struct DataModelKey: @MainActor EnvironmentKey {
    static let defaultValue = DataModel.shared
}

extension EnvironmentValues {
    @MainActor var dataModel: DataModel {
        get { self[DataModelKey.self] }
        set { self[DataModelKey.self] = newValue }
    }
}
