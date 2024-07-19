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
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                
                VStack(spacing: 12) {
                    AsyncImage(url: URL(string: results.image)) { phase in
                        phase.image?
                            .resizable()
                            .frame(maxWidth: 320, maxHeight: 320)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    }
                    
                    Button(action: {}) {
                               Text(results.status)
                                   .font(.custom("IBMPlexSans-SemiBold", size: 16))
                                   .foregroundColor(.white)
                                   .frame(maxWidth: 320, maxHeight: 42)
                                   .background(statusColor(status: results.status))
                                   .clipShape(Capsule())
                           }
                           .buttonStyle(PlainButtonStyle())
                           .cornerRadius(16)
                    
                }
                
                VStack(alignment: .leading) {
                    Text("Species: \(results.species)")
                    Text("Gender: \(results.gender)")
                    Text("Episodes: \(extractEpisodeNumbers(from: results.episode))")
                    Text("Last known location: \(results.location.name)")
                }
                .font(.custom("IBMPlexSans-Regular", size: 14))
                
            }
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 20.0))
            
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(results.name)
                    .font(.custom("IBMPlexSans-Bold", size: 24))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .containerRelativeFrame([.horizontal, .vertical])
        //        .background(Color(UIColor.label))
    }
    
    func statusColor(status: String) -> Color {
            switch status.lowercased() {
            case "alive":
                return Color.green.opacity(0.6)
            case "dead":
                return Color.red.opacity(0.6)
            case "unknown":
                return Color.gray.opacity(0.6)
            default:
                return Color.gray.opacity(0.6)
            }
        }
    ///function takes an array of URLs, extracts the last component of each URL
    func extractEpisodeNumbers(from urls: [String]) -> String {
        return urls.compactMap { url in
            URL(string: url)?.lastPathComponent
        }.joined(separator: ", ")
    }
}
