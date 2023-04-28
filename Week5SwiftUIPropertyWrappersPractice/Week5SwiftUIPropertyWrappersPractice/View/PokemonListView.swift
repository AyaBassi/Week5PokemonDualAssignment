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
                    List{
                        ForEach(coredataManger.savedPokemonEntities){pokemon in
                            NavigationLink {
                                //PokemonDetailsPage(pokemon: pokemon)
                            } label: {
                                VStack(alignment: .leading){
                                    PokemonListCell(imageUrl: pokemon.smallImageUrl ?? "No Image", name: pokemon.name ?? "No name")
                                        .onTapGesture {
                                        coredataManger.updatePokemon(entity: pokemon)
                                    }
                                }.multilineTextAlignment(.leading)
                            }
                        }.onDelete { indexSet in
                            coredataManger.deletePokemon(indexSet: indexSet)
                        }
                    }
                }
            }.onAppear{
                Task{
                    //printCoredataSqliteLocationPath(coredataModelName:"PokemonCorDataContainer")
                }
            }.refreshable {
                //await getAPIData()
                coredataManger.fetchPokemons()
            }//.padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Delete All") {
                        coredataManger.deleteAll()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reset All Data") {
                        coredataManger.deleteAll()
                        Task{
                            await apiCallToGetAllPokemonData()
                        }
                    }
                }
            }
        }
//        .sheet(isPresented: $isNextScreenShow) {
//            CreateQuestionScreen(isShown: $isNextScreenShow)
//        }
        
//        .fullScreenCover(isPresented: $isNextScreenShow) {
//            CreateQuestionScreen(isShown: $isNextScreenShow)
//        }
        
    }
    func apiCallToGetAllPokemonData()async{
        await pokemonViewModel.getListOfPokemons(
            withUrlString: APIEndPoint.pokemonListEndPointUrl,
            coredataManager: coredataManger)
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
    
    func printCoredataSqliteLocationPath(coredataModelName:String){
        guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {return}
       
        let sqlitePath = url.appendingPathComponent("\(coredataModelName).sqlite"
        )
        print(sqlitePath)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
