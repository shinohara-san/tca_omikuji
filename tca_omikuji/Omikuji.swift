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
        @BindingState var isOmikujiOn = true
    }
    
    enum Action: BindableAction, Equatable {
        case omikujiButtonTapped
        case resetButtonTapped
        case binding(BindingAction<State>)
    }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
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
//                state = Omikuji.State()
                return .none
            case .binding(\.$isOmikujiOn):
                state.isOmikujiOn = state.isOmikujiOn
                return .none
            case .binding:
                return .none
            }
        }
    }
}
