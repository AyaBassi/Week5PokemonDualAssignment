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
    
    func savePokemonData(pokemons: [PokemonSuitableForUIWithId]){
        pokemons.forEach { pokemon in
            let pokemonEntity = PokemonEntity(context: container.viewContext)
            pokemonEntity.name = pokemon.name
            pokemonEntity.id = pokemon.id
            pokemonEntity.theId = pokemon.theId
            pokemonEntity.largeImageUrl = pokemon.images.large
            pokemonEntity.smallImageUrl = pokemon.images.small
        }
         saveData()
    }
    
    func fetchPokemons()  {
        let nsFetchRequest = NSFetchRequest<PokemonEntity>(entityName: "PokemonEntity")
        do {
            savedPokemonEntities = try container.viewContext.fetch(nsFetchRequest)
            
            print(savedPokemonEntities.count)
        }catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func updatePokemon(entity: PokemonEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func deletePokemon(indexSet:IndexSet) {
        guard let index = indexSet.first else {return}
        let entity = savedPokemonEntities[index]
        container.viewContext.delete(entity)
         saveData()
    }
    
    func deleteAll() {
        savedPokemonEntities.forEach { pokemonEntity in
            container.viewContext.delete(pokemonEntity)
        }
         saveData()
    }
    
    func saveData()  {
        do{
            try container.viewContext.save()
             fetchPokemons()
        }catch let error {
            print("ERROR saving. \(error)")
        }
    }
    
}
