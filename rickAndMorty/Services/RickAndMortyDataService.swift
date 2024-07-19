//
//  RickAndMortyDataService.swift
//  rickAndMorty
//
//  Created by test on 17.07.2024.
//

import Foundation
import Combine

final class RickAndMortyDataServices: RickAndMortyServices {
    func getAllcharacters() -> AnyPublisher<Characters, any Error> {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/") else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Characters.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
