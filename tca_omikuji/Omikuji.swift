//
//  Omikuji.swift
//  tca_omikuji
//
//  Created by shinohara.yuki.2250 on 2023/03/06.
//

import ComposableArchitecture

struct Omikuji: ReducerProtocol {
    struct State: Equatable {
        var imageName: String = "omikuji"
    }
    
    enum Action: Equatable {
        case omikujiButtonTapped
        case resetButtonTapped
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .omikujiButtonTapped:
            let num = Int.random(in: 0...2)
            switch num {
            case 0:
                state.imageName = "daikichi"
            case 1:
                state.imageName = "kichi"
            case 2:
                state.imageName = "kyou"
            default:
                fatalError("Unexpected num")
            }
            return .none
        case .resetButtonTapped:
            state.imageName = "omikuji"
            return .none
        }
    }
}
