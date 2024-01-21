//
//  ViewModel.swift
//  wordleGame
//
//  Created by Daniel Boza García on 19/1/24.
//

import Foundation

final class ViewModel: ObservableObject {
    var numOfRow: Int = 0
    @Published var word: [LetterModel] = []
    @Published var gameData: [[LetterModel]] = [
        [.init(""), .init(""), .init(""), .init(""), .init("")],
        [.init(""), .init(""), .init(""), .init(""), .init("")],
        [.init(""), .init(""), .init(""), .init(""), .init("")],
        [.init(""), .init(""), .init(""), .init(""), .init("")],
        [.init(""), .init(""), .init(""), .init(""), .init("")],
        [.init(""), .init(""), .init(""), .init(""), .init("")],
    ]
    
    func addNewLetter(letterModel: LetterModel) {
        if letterModel.name == "🚀" {
            tapOnSend()
            return
        }
        
        if letterModel.name == "🗑️" {
            tapOnTrash()
            return
        }
        
        if word.count < 5 {
            let letter = LetterModel(letterModel.name)
            word.append(letter)
            gameData[numOfRow][word.count-1] = letter
            print("\(letter.name)")
            print("\(word.count)")
        }
    }
    
    private func tapOnSend() {
        print("Enviando...")
    }
    
    private func tapOnTrash() {
        print("Borrando...")
    }
}
