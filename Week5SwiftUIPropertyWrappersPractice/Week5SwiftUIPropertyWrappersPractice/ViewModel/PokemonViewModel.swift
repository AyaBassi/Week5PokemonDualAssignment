//
//  PokemonViewModel.swift
//  Week5SwiftUIPropertyWrappersPractice
//
//  Created by Payam Karbassi on 24/04/2023.
//

import Foundation
@MainActor
class PokemonViewModel : ObservableObject{
    
    @Published var pokemonList = [PokemonSuitableForUIWithId]()
    @Published var networkErrorEnum:NetworkErrorEnum?
    @Published var coredataManager = CoredataManager()
    
    var anyManager: NetworkableProtocol
    
    init(manager:NetworkableProtocol){
        self.anyManager = manager
    }
    
    func getListOfPokemons(withUrlString urlString: String) async{
        guard let url = URL(string: urlString) else {
            networkErrorEnum = NetworkErrorEnum.invalidUrlError
            return
        }
        
        guard let data = try? await self.anyManager.getDataFromAPI(url: url) else {
            networkErrorEnum = NetworkErrorEnum.dataNotFoundError
            return
        }
        guard let pokemonData = try? JSONDecoder().decode(PokemonDataModel.self, from: data)else {
            networkErrorEnum = NetworkErrorEnum.parsingError
            return
        }
        
        let pokemonList_WithId_SuitableForUI = pokemonData.data.map { pokemon in
            PokemonSuitableForUIWithId(name: pokemon.name, id: pokemon.id, images: pokemon.images)
            
        }
        
        self.pokemonList = pokemonList_WithId_SuitableForUI
        try? await coredataManager.savePokemonData(pokemons: pokemonList)
    }
}
