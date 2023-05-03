//
//  ContentView.swift
//  CarProject
//
//  Created by GABRIEL PALAFOX SUAREZ on 25/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var carList: [CarDB] = getCars()
    
    var body: some View {
        //CarList(carData: $carList)
        NavigationView {
            VStack {
                HStack(spacing: 30) {
                    NavigationLink(destination: AditionCarView(carList: $carList), label: {
                        Text("Add")
                    })
                    Button("Update") {
                        carList = getCars()
                    }
                }.padding()
                CarList(carData: $carList)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
