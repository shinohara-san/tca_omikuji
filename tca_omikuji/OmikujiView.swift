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
                    .background(.red)
                    .foregroundColor(.white)
                    
                    Button("Omikuji") {
                        viewStore.send(.omikujiButtonTapped)
                    }
                    .buttonStyle(.bordered)
                    .background(.green)
                    .foregroundColor(.white)
                }
                .padding()
            }
            .padding()
        }
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
