//
//  ContentView.swift
//  rickAndMorty
//
//  Created by test on 17.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel: RickAndMortyViewModel = RickAndMortyViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                switch viewModel.charactersState{
                    
                case .initial:
                    ProgressView()
                case .loading:
                    ProgressView()
                case .error(let error):
                    Text(error)
                case .loaded (let data):
                    
                    List {
                        ForEach(data.results) { results in
                            VStack {
                                NavigationLink(destination: DetailView(results: results)) {
                                    HStack(spacing: 16) {
                                        AsyncImage(url: URL(string: results.image)) { image in
                                            image.resizable()
                                                .cornerRadius(12)
                                        } placeholder: {
                                            ProgressView ()
                                        }
                                        .frame(width: 84, height: 64)
                                        
                                        VStack(alignment: .leading) {
                                            Text(results.name)
                                                .font(.headline)
                                                .fontWeight(.medium)
                                            HStack(spacing: 3) {
                                                Text(results.status)
                                                    .foregroundStyle(viewModel.statusColor(status: results.status))
                                                Text("•")
                                                Text (results.species)
                                                    .font(.footnote)
                                                    .fontWeight(.light)
                                            }
                                            Text(results.gender)
                                                .font(.subheadline)
                                                .fontWeight(.regular)
                                        }
                                    }
                                    .padding()
//                                    .background(.black)
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                    
                                }
                                .toolbarRole(.editor)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .padding([.top, .bottom])
                    .scrollContentBackground(.hidden)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Rick & Morty Characters")
                                .font(.custom("IBMPlexSans-Bold", size: 24))
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}


