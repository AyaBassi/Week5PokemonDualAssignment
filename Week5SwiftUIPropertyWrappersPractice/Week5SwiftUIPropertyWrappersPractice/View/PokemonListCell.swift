//
//  PokemonListCell.swift
//  Week5SwiftUIPropertyWrappersPractice
//
//  Created by Payam Karbassi on 25/04/2023.
//

import SwiftUI

struct PokemonListCell: View {
    var imageUrl:String
    var name:String
    var body: some View {
        
        HStack{
            AsyncImage(
                url: URL(string: imageUrl),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 100, maxHeight: 100)
                },
                placeholder: {
                    ProgressView()
                }
            ).cornerRadius(10)
            Text(name).font(.title3)
        }
        
    }
}
    
    struct PokemonListCell_Previews: PreviewProvider {
        static var previews: some View {
            PokemonListCell(imageUrl: "", name: "")
        }
    }
