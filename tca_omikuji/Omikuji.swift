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
        var confirmationDialog: ConfirmationDialogState<Action>?
    }
    
    enum Action: BindableAction, Equatable {
        case omikujiButtonTapped
        case resetButtonTapped
        case resetOmikuji
        case binding(BindingAction<State>)
        case alertDismissed
        case confirmationDialogDismissed
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
                if state.imageName == Luck.default.rawValue {
                    state.alert = AlertState { TextState("Get your Omikuji first") }
                    return .none
                }
                state.confirmationDialog = ConfirmationDialogState {
                    TextState("これどこで使われてる？")
                } actions: {
                    ButtonState(role: .cancel) {
                        TextState("No, I don't want to")
                    }
                    ButtonState(action: .resetOmikuji) {
                        TextState("Yes, please")
                    }
                } message: {
                    TextState("Are you sure to reset?")
                }
                return .none
            case .resetOmikuji:
                state.imageName = Luck.`default`.rawValue
                return .none
            case .binding:
                return .none
            case .alertDismissed:
                state.alert = nil
                return .none
            case .confirmationDialogDismissed:
                state.confirmationDialog = nil
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
