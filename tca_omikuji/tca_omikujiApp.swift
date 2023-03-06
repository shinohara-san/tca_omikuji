//
//  tca_omikujiApp.swift
//  tca_omikuji
//
//  Created by shinohara.yuki.2250 on 2023/03/06.
//

import SwiftUI
import ComposableArchitecture

@main
struct tca_omikujiApp: App {
    var body: some Scene {
        WindowGroup {
            OmikujiView(store: Store(
                initialState: Omikuji.State(),
                reducer: Omikuji())
            )
        }
    }
}
