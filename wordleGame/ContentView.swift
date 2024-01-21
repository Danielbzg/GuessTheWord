//
//  ContentView.swift
//  wordleGame
//
//  Created by Daniel Boza García on 19/1/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        VStack(spacing: 40) {
            GameView(viewModel: viewModel)
            KeyboardView(viewModel: viewModel)
        }
    }
}

#Preview {
    ContentView()
}
