//
//  PokemonDataModel.swift
//  Week5SwiftUIPropertyWrappersPractice
//
//  Created by Payam Karbassi on 24/04/2023.
//

import Foundation

struct PokemonDataModel: Decodable{
    let data: [Pokemon]
}

struct PokemonSuitableForUIWithId : Identifiable{
    let theId = UUID()
    let name : String
    let id: String
    let images: DatumImages
}

// MARK: - Datum
struct Pokemon: Decodable {
    let id, name: String
//        let supertype: Supertype
//        let subtypes: [String]
//        let level: String?
//        let hp: String
//        let types: [String]
//        let evolvesFrom: String?
//        let abilities: [Ability]?
//        let attacks: [Attack]
//        let weaknesses: [Resistance]
//        let resistances: [Resistance]?
//        let retreatCost: [RetreatCost]?
//        let convertedRetreatCost: Int?
//        let datumSet: Set
//        let number, artist: String
//        let rarity: Rarity?
//        let nationalPokedexNumbers: [Int]
//        let legalities: Legalities
        let images: DatumImages
//        let tcgplayer: Tcgplayer?
//        let cardmarket: Cardmarket
//        let evolvesTo: [String]?
//        let flavorText: String?

//        enum CodingKeys: String, CodingKey {
//            case id, name, supertype, subtypes, level, hp, types, evolvesFrom, abilities, attacks, weaknesses, resistances, retreatCost, convertedRetreatCost
//            case datumSet = "set"
//            case number, artist, rarity, nationalPokedexNumbers, legalities, images, tcgplayer, cardmarket, evolvesTo, flavorText
//        }
    
}

//// MARK: - Ability
//struct Ability: Decodable {
//    let name, text, type: String
//}
//
//// MARK: - Attack
//struct Attack: Decodable {
//    let name: String
//    let cost: [String]
//    let convertedEnergyCost: Int
//    let damage, text: String
//}
//
//// MARK: - Cardmarket
//struct Cardmarket: Decodable {
//    let url: String
//    let updatedAt: UpdatedAt
//    let prices: [String: Double]
//}
//
//enum UpdatedAt: String, Decodable {
//    case the20230424 = "2023/04/24"
//}
//
//// MARK: - Set
//struct Set: Decodable {
//    let id, name, series: String
//    let printedTotal, total: Int
//    let legalities: Legalities
//    let ptcgoCode: String?
//    let releaseDate, updatedAt: String
//    let images: SetImages
//}
//
//// MARK: - SetImages
//struct SetImages: Decodable {
//    let symbol, logo: String
//}
//
//// MARK: - Legalities
//struct Legalities: Decodable {
//    let unlimited: Expanded
//    let expanded: Expanded?
//}
//
//enum Expanded: String, Decodable {
//    case legal = "Legal"
//}
//
//// MARK: - DatumImages
struct DatumImages: Decodable {
    let small, large: String
}
//
//enum Rarity: String, Decodable {
//    case common = "Common"
//    case rareHolo = "Rare Holo"
//}
//
//// MARK: - Resistance
//struct Resistance: Decodable {
//    let type, value: String
//}
//
//enum RetreatCost: String, Decodable {
//    case colorless = "Colorless"
//}
//
//enum Supertype: String, Decodable {
//    case pokémon = "Pokémon"
//}
//
//// MARK: - Tcgplayer
//struct Tcgplayer: Decodable {
//    let url: String
//    let updatedAt: UpdatedAt
//    let prices: Prices
//}
//
//// MARK: - Prices
//struct Prices: Decodable {
//    let holofoil, reverseHolofoil, normal: Holofoil?
//}
//
//// MARK: - Holofoil
//struct Holofoil: Decodable {
//    let low, mid, high, market: Double
//    let directLow: Double?
//}
