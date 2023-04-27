//
//  PokemonModelViewTests.swift
//  Week5SwiftUIPropertyWrappersPracticeTests
//
//  Created by Payam Karbassi on 26/04/2023.
//

import XCTest
@testable import Week5SwiftUIPropertyWrappersPractice
final class PokemonModelViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testGetListOfPokemons_Positively()async throws {
        let pokemonViewModel = await PokemonViewModel(manager: FakeNetworkManager())
        XCTAssertNotNil(pokemonViewModel)
        await pokemonViewModel.getListOfPokemons(withUrlString:"PokemonTestFile" )
        // the count needs to be dont in the same thread as the testing because the viewModel is marked with @MainActor
        let pokemonListCount = await pokemonViewModel.pokemonList.count
        XCTAssertEqual(pokemonListCount, 5)
        XCTAssertNotEqual(pokemonListCount, 4)
        let error = await pokemonViewModel.networkErrorEnum
        XCTAssertNil(error)
    }
    
    func testGetListOfPokemons_WithInvalidUrl()async throws {
        let pokemonViewModel = await PokemonViewModel(manager: FakeNetworkManager())
        XCTAssertNotNil(pokemonViewModel)
        await pokemonViewModel.getListOfPokemons(withUrlString:"" )
        // the count needs to be dont in the same thread as the testing because the viewModel is marked with @MainActor
        let pokemonListCount = await pokemonViewModel.pokemonList.count
        XCTAssertEqual(pokemonListCount, 0)
        XCTAssertNotEqual(pokemonListCount, 5)
        let error = await pokemonViewModel.networkErrorEnum
        XCTAssertNotNil(error)
        // also check NetworkErrorEnum case for .invalidUrlError
        XCTAssertEqual(error, NetworkErrorEnum.invalidUrlError)
    }
    
    func testGetListOfPokemons_WithValidUrlButEmptyFile()async throws {
        let pokemonViewModel = await PokemonViewModel(manager: FakeNetworkManager())
        XCTAssertNotNil(pokemonViewModel)
        await pokemonViewModel.getListOfPokemons(withUrlString:"PokemonTestFileEmpty" )
        // the count needs to be dont in the same thread as the testing because the viewModel is marked with @MainActor
        let pokemonListCount = await pokemonViewModel.pokemonList.count
        XCTAssertEqual(pokemonListCount, 0)
        XCTAssertNotEqual(pokemonListCount, 5)
        let error = await pokemonViewModel.networkErrorEnum
        // also check NetworkErrorEnum case for .invalidUrlError
        XCTAssertEqual(error, NetworkErrorEnum.parsingError)
    }
    
    func testGetListOfPokemons_ForActualData()async throws {
        let pokemonViewModel = await PokemonViewModel(manager: FakeNetworkManager())
        await pokemonViewModel.getListOfPokemons(withUrlString:"PokemonTestFile" )
        let firstPokemon = await pokemonViewModel.pokemonList[0]
        XCTAssertEqual(firstPokemon.name, "Ampharos")
        XCTAssertEqual(firstPokemon.id, "pl1-1")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
