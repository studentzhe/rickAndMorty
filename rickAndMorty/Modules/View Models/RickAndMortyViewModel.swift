//
//  RickAndMortyViewModel.swift
//  rickAndMorty
//
//  Created by test on 17.07.2024.
//

import SwiftUI
import Combine

final class RickAndMortyViewModel : ObservableObject {
    
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
                return Colors.greenAlive
            case "dead":
                return Colors.redDead
            case "unknown":
                return Colors.greyUnknown
            default:
                return Color.green
            }
        }
}
