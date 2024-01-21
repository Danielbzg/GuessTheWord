//
//  ViewModel.swift
//  wordleGame
//
//  Created by Daniel Boza García on 19/1/24.
//

import Foundation
import UIKit

enum BannerType {
    case error(String)
    case success
}

final class ViewModel: ObservableObject {

    var numOfRow: Int = 0
    @Published var bannerType: BannerType? = nil
    @Published var result: String = "REINA"
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
        bannerType = nil //Reseteo
        
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
        guard word.count == 5 else {
            print("Añade más letras")
            bannerType = .error("Añade más letras")
            return
        }
        
        let finalStringWord = word.map { $0.name }.joined()
        
        if wordIsReal(word: finalStringWord) {
            print("Correct word")
            
            for (index, _) in word.enumerated() {
                let currentCharacter = word[index].name
                var status: Status
                
                if result.contains(where: { String($0) == currentCharacter }) {
                    status = .appear
                    print("\(currentCharacter) .appear")
                    
                    if currentCharacter == String(result[result.index(result.startIndex, offsetBy: index)]) {
                        status = .match
                        print("\(currentCharacter) .match")
                    }
                } else {
                    status = .dontAppear
                    print("\(currentCharacter) .dontAppear")
                }
                
                //Actualizar juego
                var updateGameBoardCell = gameData[numOfRow][index]
                updateGameBoardCell.status = status
                gameData[numOfRow][index] = updateGameBoardCell
                
                //Actualizar Vista del Teclado
                let indexToUpdate = keyboardData.firstIndex(where: {$0.name == word[index].name })
                var keyboardKey = keyboardData[indexToUpdate!]
                if keyboardKey.status != .match {
                    keyboardKey.status = status
                    keyboardData[indexToUpdate!] = keyboardKey
                }
            }
            
            //Limpiar palabra y pasar al siguiente intento
            word = []
            numOfRow += 1
        } else {
            print("Incorrect word")
            bannerType = .error("Incorrect word, no existe")
        }
    }
    
    func hasError(index: Int) -> Bool {
        guard let bannerType = bannerType else {
            return false
        }
        switch bannerType {
        case .error(_):
            return index == numOfRow
        case .success:
            return false
        }
    }
    
    private func tapOnTrash() {
        print("Borrando...")
        guard word.count > 0 else {
            return
        }
        gameData[numOfRow][word.count-1] = .init("")
        word.removeLast()
    }
    
    private func wordIsReal(word: String) -> Bool {
        //Si existe en el diccionario retornará true si no false
        UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: word)
    }
}
