//
//  ContentView.swift
//  rickAndMorty
//
//  Created by test on 17.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel: RickAndMortyViewModel = RickAndMortyViewModel()
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.clear
        appearance.setBackIndicatorImage(UIImage(systemName: Constants.leftArrow),
                                         transitionMaskImage: UIImage(systemName: Constants.leftArrow))
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = .clear
    }
    
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
                case .loaded(let data):
                    
                    List {
                        ForEach(data.results) { results in
                            VStack {
                                NavigationLink(destination: DetailView(results: results)) {
                                    HStack(spacing: Constants.hStackSpacing) {
                                        AsyncImage(url: URL(string: results.image)) { image in
                                            image.resizable()
                                                .cornerRadius(Constants.imageCornerRadius)
                                        } placeholder: {
                                            ProgressView ()
                                        }
                                        .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                                        
                                        VStack(alignment: .leading) {
                                            Text(results.name)
                                                .font(.custom(Constants.fontSemiBold,
                                                              size: Constants.nameFontSize))
                                                .foregroundColor(Colors.baseText)
                                            HStack(spacing: Constants.smallSpacing) {
                                                Text(results.status)
                                                    .font(.custom(Constants.fontMedium,
                                                                  size: Constants.infoFontSize))
                                                    .foregroundStyle(viewModel.statusColor(status: results.status))
                                                Text(Constants.dot)
                                                    .font(.custom(Constants.fontMedium,
                                                                  size: Constants.infoFontSize))
                                                    .foregroundColor(Colors.baseText)
                                                Text(results.species)
                                                    .font(.custom(Constants.fontMedium,
                                                                  size: Constants.infoFontSize))
                                                    .foregroundColor(Colors.baseText)
                                            }
                                            Text(results.gender)
                                                .font(.custom(Constants.fontRegular,
                                                              size: Constants.infoFontSize))
                                                .foregroundColor(Colors.baseText)
                                        }
                                    }
                                    .padding()
                                }
                            }
                            .background(CustomCellBackground())
                            .padding(.horizontal, Constants.horizontalPadding)
                            .padding(.vertical, Constants.verticalPadding)
                        }
                        .listRowInsets(EdgeInsets())
                        .background(Color.clear)
                    }
                    .listStyle(.plain)
                    .padding([.top, .bottom])
                    .scrollContentBackground(.hidden)
                    .background(Colors.foreground)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text(Constants.textRickAndMorty)
                                .font(.custom(Constants.fontBold, size: Constants.titleFontSize))
                                .foregroundStyle(Colors.baseText)
                        }
                    }
                }
            }
        }
    }
}

struct CustomCellBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Colors.foregroundList)
    }
}

//MARK: - Constants

fileprivate extension ContentView {
    enum Constants {
        static let hStackSpacing: CGFloat = 16
        static let imageCornerRadius: CGFloat = 12
        static let imageWidth: CGFloat = 84
        static let imageHeight: CGFloat = 64
        static let nameFontSize: CGFloat = 18
        static let infoFontSize: CGFloat = 12
        static let smallSpacing: CGFloat = 3
        static let horizontalPadding: CGFloat = 20
        static let verticalPadding: CGFloat = 2
        static let titleFontSize: CGFloat = 24
        
        static let leftArrow = "chevron.bacward"
        static let fontMedium = "IBMPlexSans-Medium"
        static let fontSemiBold = "IBMPlexSans-SemiBold"
        static let fontRegular = "IBMPlexSans-Regular"
        static let fontBold = "IBMPlexSans-Bold"
        static let dot = "•"
        static let textRickAndMorty = "Rick & Morty Characters"
    }
}

#Preview {
    ContentView()
}


