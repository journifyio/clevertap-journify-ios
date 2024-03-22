//
//  ContentView.swift
//  BasicExample
//
//  Created by Bendnaiba on 3/20/23.
//

import SwiftUI
import Journify

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    let traits: [String: Any] = ["email": "test@gmail.com",
                                                 "name": "test",
                                                 "lastname": "test",
                                                 "city": "Casablanca",
                                                 "country": "Morocco",
                                                 "state": "AinSbaa",
                                                 "phone": "21263583173",
                                                 "ltv": 156]
                    Journify.shared().identify(userId: "2024", traits: traits)
                }, label: {
                    Text("Identify")
                }).padding(6)
            }.padding(8)
            HStack {
                Button(action: {
                    Journify.shared().track(name: "Track")
                }, label: {
                    Text("Track")
                }).padding(6)
                Button(action: {
                    Journify.shared().screen(title: "Screen appeared")
                }, label: {
                    Text("Screen")
                }).padding(6)
            }.padding(8)
        }.onAppear {
            Journify.shared().track(name: "onAppear")
            print("Executed Analytics onAppear()")
        }.onDisappear {
            Journify.shared().track(name: "onDisappear")
            print("Executed Analytics onDisappear()")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
