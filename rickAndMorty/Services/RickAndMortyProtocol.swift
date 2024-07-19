//
//  RickAndMortyProtol.swift
//  rickAndMorty
//
//  Created by test on 17.07.2024.
//

import Foundation
import Combine

protocol RickAndMortyServices {
    func getAllcharacters () -> AnyPublisher <Characters, Error>
}

