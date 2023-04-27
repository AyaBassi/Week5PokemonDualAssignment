//
//  ContentView.swift
//  Week5SwiftUIPropertyWrappersPractice
//
//  Created by Payam Karbassi on 24/04/2023.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var coredataManger = CoredataManager()
    @State var isNextScreenShow = false
    // another way of doing it pokemonViewModel, but needs to be delcared somewhere else, system might remove data if it gets to much(nil the value)
    //@ObservedObject var pokemonViewModel : PokemonViewModel
    
    @StateObject var pokemonViewModel = PokemonViewModel(manager: NetworkManager())
    @State var isErrorOccured = false
    var body: some View {
        NavigationStack{
            VStack {
                if pokemonViewModel.networkErrorEnum != nil {
                    showAlert()
                }else {
                    List (coredataManger.savedPokemonEntities){pokemon in
                        NavigationLink {
                            //PokemonDetailsPage(pokemon: pokemon)
                        } label: {
                            VStack(alignment: .leading){
                                PokemonListCell(imageUrl: pokemon.smallImageUrl ?? "No Image", name: pokemon.name ?? "No name")
                            }.multilineTextAlignment(.leading)
                        }
                    }
                }
            }.onAppear{
                Task{
                    //await getAPIData()
                    //coredataManger.fetchPokemons()
                }
                
            }.refreshable {
                //await getAPIData()
            }//.padding()
        }
//        .sheet(isPresented: $isNextScreenShow) {
//            CreateQuestionScreen(isShown: $isNextScreenShow)
//        }
        
//        .fullScreenCover(isPresented: $isNextScreenShow) {
//            CreateQuestionScreen(isShown: $isNextScreenShow)
//        }
        
    }
    func getAPIData()async{
        await pokemonViewModel.getListOfPokemons(withUrlString: APIEndPoint.pokemonListEndPointUrl)
        if pokemonViewModel.networkErrorEnum != nil {
            isErrorOccured = true
        }
    }
    //@ViewBuilder
    func showAlert()-> some View{
        ProgressView().alert(isPresented: $isErrorOccured) {
            Alert(title: Text("Oops there was a problem!"),
                  message: Text(pokemonViewModel.networkErrorEnum?.errorDescription ?? ""),
                  dismissButton: .default(Text("Okay"), action: {
                print("Alert controller is being dismissed")
            }))
        }
    }
    // seems to be working without viewBuilder
//    @ViewBuilder
//    func getListCell(pokemon:PokemonSuitableForUIWithId)-> some View{
//        VStack(alignment: .leading){
//            PokemonListCell(imageUrl: pokemon., name: <#T##String#>)
//        }.multilineTextAlignment(.leading)
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
