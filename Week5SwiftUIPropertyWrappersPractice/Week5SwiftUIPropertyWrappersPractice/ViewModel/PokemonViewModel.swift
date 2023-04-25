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
    var anyManager: NetworkableProtocol
    
    init(manager:NetworkableProtocol){
        self.anyManager = manager
    }
    
    func getListOfPokemons(withUrlString urlString: String) async{
        
        guard let url = URL(string: urlString) else {
            networkErrorEnum = NetworkErrorEnum.invalidUrlError
            return
        }
        do {
            let data = try await self.anyManager.getDataFromAPI(url: url)
            let pokemonData = try JSONDecoder().decode(PokemonDataModel.self, from: data)
            let pokemonList_WithId_SuitableForUI = pokemonData.data.map { pokemon in
                PokemonSuitableForUIWithId(name: pokemon.name, id: pokemon.id, images: pokemon.images)
            }
            
            self.pokemonList = pokemonList_WithId_SuitableForUI
            
        }catch let error{
            switch error{
            case let decodingError as DecodingError:
                networkErrorEnum = .parsingError
            case let apiError as NetworkErrorEnum:
                networkErrorEnum = .dataNotFoundError
            default:
                networkErrorEnum = .dataNotFoundError
            }
            //            if ((error as? DecodingError) != nil) {
            //                networkErrorEnum = .parsingError
            //            }else {
            //                networkErrorEnum = .dataNotFoundError
            //            }
            print("DEBGU: ",error.localizedDescription)
        }
    }
}
