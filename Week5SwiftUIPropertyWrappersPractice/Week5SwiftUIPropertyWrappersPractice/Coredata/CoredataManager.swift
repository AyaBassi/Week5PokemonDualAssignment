//
//  CoredataViewModel.swift
//  Week5SwiftUIPropertyWrappersPractice
//
//  Created by Payam Karbassi on 27/04/2023.
//

import CoreData
import Foundation
class CoredataManager : ObservableObject , CoredataOperationProtocol{
    
    
    
    let container : NSPersistentContainer
    
    @Published var savedPokemonEntities : [PokemonEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "PokemonCorDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("DEBUG: Error loading core data.\(error)")
            }else{
                print("DEBUG: Successfully loaded core data!")
            }
        }
        fetchPokemons()
    }
    
    
    
    func fetchPokemons(){
        let nsFetchRequest = NSFetchRequest<PokemonEntity>(entityName: "PokemonEntity")
        do {
            savedPokemonEntities = try container.viewContext.fetch(nsFetchRequest)
            //print(savedPokemonEntities.count)
        }catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func savePokemonData(pokemons: [PokemonSuitableForUIWithId])async throws {
        let pokemonEntity = PokemonEntity(context: container.viewContext)
        pokemons.forEach { pokemon in
            pokemonEntity.name = pokemon.name
            pokemonEntity.id = pokemon.id
            pokemonEntity.theId = pokemon.theId
            pokemonEntity.largeImageUrl = pokemon.images.large
            pokemonEntity.smallImageUrl = pokemon.images.small
        }
        try? saveData()
    }
    
//    func savePokemon(pokemon:[PokemonSuitableForUIWithId]){
//        let pokemonEntity = PokemonEntity(context: container.viewContext)
//
//
////        newPokemon.name = pokemon.name
////        newPokemon.id = pokemon.id
////        newPokemon.theId = pokemon.theId
////        newPokemon.largeImageUrl = pokemon.images.large
////        newPokemon.smallImageUrl = pokemon.images.small
//        saveData()
//    }
//
    func saveData()throws{
        do{
            try container.viewContext.save()
            fetchPokemons()
        }catch let error {
            print("ERROR saving. \(error)")
            throw error
        }
    }
    
}
