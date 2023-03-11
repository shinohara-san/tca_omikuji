//
//  Omikuji.swift
//  tca_omikuji
//
//  Created by shinohara.yuki.2250 on 2023/03/06.
//

import ComposableArchitecture

struct Omikuji: ReducerProtocol {
    struct State: Equatable {
        var imageName: String = Luck.default.rawValue
        @BindingState var isOmikujiOn = true
        var alert: AlertState<Action>?
    }
    
    enum Action: BindableAction, Equatable {
        case omikujiButtonTapped
        case resetButtonTapped
        case binding(BindingAction<State>)
        case alertDismissed
    }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .omikujiButtonTapped:
                let num = Int.random(in: 0...2)
                switch num {
                case 0:
                    state.imageName = Luck.daikichi.rawValue
                case 1:
                    state.imageName = Luck.kichi.rawValue
                case 2:
                    state.imageName = Luck.kyou.rawValue
                default:
                    fatalError("Unexpected num")
                }
                state.alert = AlertState { TextState(Luck(rawValue: state.imageName)?.alertTitle ?? "Error") }
                return .none
            case .resetButtonTapped:
                state.imageName = Luck.`default`.rawValue
                return .none
            case .binding:
                return .none
            case .alertDismissed:
                state.alert = nil
                return .none
            }
        }
    }
}

enum Luck: String {
    case daikichi, kichi, kyou, `default` = "omikuji"

    var alertTitle: String {
        switch self {
        case .daikichi:
            return "大吉"
        case .kichi:
            return "吉"
        case .kyou:
            return "凶"
        default:
            fatalError("Unexpected case")
        }
    }
}
