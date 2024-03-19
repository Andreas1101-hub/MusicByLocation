//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Andreas Kwong on 19/03/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationHandler = LocationHandler()
    
    var body: some View {
        VStack {
            Form {
                Section ("Location") {
                    Text("Country: \(locationHandler.lastKnownCountry)")
                    Text("City: \(locationHandler.lastKnownLocation)")
                    Text("Post Code: \(locationHandler.lastKnownPostCode)")
                    Text("Address: \(locationHandler.lastKnownAddress)")
                }
            }
            
            Spacer()
            Button("Find Music", action: {
                locationHandler.requestLocation()
            })
        } .onAppear(perform: {
            locationHandler.requestAuthorisation()
        })
    }
}

#Preview {
    ContentView()
}
