//
//  CreateQuestionScreen.swift
//  Week5SwiftUIPropertyWrappersPractice
//
//  Created by Payam Karbassi on 24/04/2023.
//

import SwiftUI

struct PokemonDetailsPage: View {
    
    var pokemon : PokemonSuitableForUIWithId
    var body: some View {
        VStack{
            Text(pokemon.name)
            Text(pokemon.id)
        }
        
    }
}

struct CreateQuestionScreen_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsPage(pokemon: PokemonSuitableForUIWithId(name: "", id: "", images: .init(small: "", large: "")))
    }
}
