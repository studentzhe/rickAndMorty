//
//  RickAndMortyViewModel.swift
//  rickAndMorty
//
//  Created by test on 17.07.2024.
//

import SwiftUI
import Combine

class RickAndMortyViewModel : ObservableObject {
    
    @Published var charactersState: CharacterViewModelState = CharacterViewModelState.initial
    
    let rickAndMortyDataService: RickAndMortyDataServices = RickAndMortyDataServices()
    var cancellable = Set<AnyCancellable> ()
    
    
    init () {
        getAllCharacters()
    }
    
    
    func getAllCharacters () {
        charactersState = CharacterViewModelState.loading
        rickAndMortyDataService.getAllcharacters()
            .sink { [weak self] completion in
                switch completion{
                    
                case .finished:
                    print ("finish")
                case .failure (let error):
                    self?.charactersState = CharacterViewModelState.error(errorMessage: "\(error)")
                }
            } receiveValue: { [weak self] Characters in
                self?.charactersState = CharacterViewModelState.loaded(characters: Characters)
            }
            .store(in: &cancellable)
    }
    
    func statusColor(status: String) -> Color {
            switch status.lowercased() {
            case "alive":
                return Color.green.opacity(0.6)
            case "dead":
                return Color.red.opacity(0.6)
            case "unknown":
                return Color.gray.opacity(0.6)
            default:
                return Color.gray.opacity(0.6)
            }
        }
}
