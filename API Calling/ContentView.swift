//
//  ContentView.swift
//  API Calling
//
//  Created by Owen Johnson on 2/27/23.
//

import SwiftUI

import Foundation
import SwiftUI
struct ContentView: View {
    @State private var image: String = ""
    @State private var ping = false
    var body: some View {
        if ping == true {
            Link("See on the web", destination: URL(string: image)!)
            AsyncImage(url: URL(string: image)!)
                .frame(maxWidth: 300, maxHeight: 100)
                .scaledToFit()

                
        }
        Button {
            Task {
                let (data, _) = try await URLSession.shared.data(from: URL(string:"https://dog.ceo/api/breeds/image/random")!)
                let decodedResponse = try? JSONDecoder().decode(Images.self, from: data)
            
                image = decodedResponse?.message ?? ""
                ping = true
            }
            
        } label: {
            Text("Find Dog")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct Images: Codable {
    let message : String
}
