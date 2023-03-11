//
//  ContentView.swift
//  tca_omikuji
//
//  Created by shinohara.yuki.2250 on 2023/03/06.
//

import SwiftUI
import ComposableArchitecture

struct OmikujiView: View {
    let store: StoreOf<Omikuji>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Image(viewStore.imageName)
                    .resizable()
                    .padding()
                HStack {
                    Button("Reset") {
                        viewStore.send(.resetButtonTapped)
                    }
                    .buttonStyle(.bordered)
                    .background(viewStore.isOmikujiOn ? .red : .secondary)
                    .foregroundColor(.white)
                    .disabled(!viewStore.isOmikujiOn)
                    
                    Button("Omikuji") {
                        viewStore.send(.omikujiButtonTapped)
                    }
                    .buttonStyle(.bordered)
                    .background(viewStore.isOmikujiOn ? .green : .secondary)
                    .foregroundColor(.white)
                    .disabled(!viewStore.isOmikujiOn)
                }
                .padding()

                Toggle("Turn \(viewStore.isOmikujiOn ? "off" : "on") Omikuji", isOn: viewStore.binding(\.$isOmikujiOn))
                    .padding()
            }
            .padding()
        }
        .alert(self.store.scope(state: \.alert),
               dismiss: .alertDismissed
        )
    }
}

struct OmikujiView_Previews: PreviewProvider {
    static var previews: some View {
        OmikujiView(store: Store(
            initialState: Omikuji.State(),
            reducer: Omikuji())
        )
    }
}
