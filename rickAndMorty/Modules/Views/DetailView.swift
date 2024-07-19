//
//  DetailView.swift
//  rickAndMorty
//
//  Created by test on 18.07.2024.
//

import SwiftUI

struct DetailView: View {
    
    let results: Results
    
    var body: some View {
        VStack(spacing: .zero) {
            VStack(alignment: .leading, spacing: Constants.innerVStackSpacing) {
                
                VStack(spacing: Constants.innerVStackSpacing) {
                    AsyncImage(url: URL(string: results.image)) { phase in
                        phase.image?
                            .resizable()
                            .frame(maxWidth: Constants.imageMaxWidth,
                                   maxHeight: Constants.imageMaxHeight)
                            .clipShape(RoundedRectangle(cornerRadius: Constants.imageCornerRadius))
                    }
                    
                    Button(action: {}) {
                        Text(results.status)
                            .font(.custom("IBMPlexSans-SemiBold", size: Constants.statusFontSize))
                            .foregroundColor(.white)
                            .frame(maxWidth: Constants.statusMaxWidth,
                                   maxHeight: Constants.statusMaxHeight)
                            .background(statusColor(status: results.status))
                            .clipShape(Capsule())
                    }
                    .buttonStyle(PlainButtonStyle())
                    .cornerRadius(Constants.buttonCornerRadius)
                }
                
                VStack(alignment: .leading) {
                    Text("Species: \(results.species)")
                    Text("Gender: \(results.gender)")
                    Text("Episodes: \(extractEpisodeNumbers(from: results.episode))")
                    Text("Last known location: \(results.location.name)")
                }
                .font(.custom("IBMPlexSans-Regular",
                              size: Constants.infoFontSize))
                .fontWeight(.semibold)
            }
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: Constants.outerVStackCornerRadius))
            
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(results.name)
                    .font(.custom("IBMPlexSans-Bold",
                                  size: Constants.titleFontSize))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .containerRelativeFrame([.horizontal, .vertical])
    }
    
    func statusColor(status: String) -> Color {
        switch status.lowercased() {
        case "alive":
            return Colors.greenAlive
        case "dead":
            return Colors.redDead
        case "unknown":
            return Colors.greyUnknown
        default:
            return Color.green
        }
    }
    
    /// Function takes an array of URLs, extracts the last component of each URL
    func extractEpisodeNumbers(from urls: [String]) -> String {
        return urls.compactMap { url in
            URL(string: url)?.lastPathComponent
        }.joined(separator: ", ")
    }
}

//MARK: - Constants

fileprivate extension DetailView {
    enum Constants {
        static let innerVStackSpacing: CGFloat = 12
        static let imageMaxWidth: CGFloat = 320
        static let imageMaxHeight: CGFloat = 320
        static let imageCornerRadius: CGFloat = 10
        static let statusFontSize: CGFloat = 16
        static let statusMaxWidth: CGFloat = 320
        static let statusMaxHeight: CGFloat = 42
        static let buttonCornerRadius: CGFloat = 16
        static let infoFontSize: CGFloat = 16
        static let outerVStackCornerRadius: CGFloat = 20
        static let titleFontSize: CGFloat = 24
    }
}
