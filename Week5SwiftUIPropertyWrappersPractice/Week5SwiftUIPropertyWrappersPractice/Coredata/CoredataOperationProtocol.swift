//
//  CoredataOperationProtocol.swift
//  Week5SwiftUIPropertyWrappersPractice
//
//  Created by Payam Karbassi on 27/04/2023.
//

import Foundation

protocol CoredataOperationProtocol {
    func savePokemonData(pokemons:[PokemonSuitableForUIWithId])
    func fetchPokemons() 
    func deletePokemon(indexSet:IndexSet)
    func updatePokemon(entity: PokemonEntity)
}
