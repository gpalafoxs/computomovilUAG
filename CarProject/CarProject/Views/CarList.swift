//
//  CarList.swift
//  CarProject
//
//  Created by GABRIEL PALAFOX SUAREZ on 25/04/23.
//

import SwiftUI

struct CarList: View {
    
    // @State private var carList: [CarDB] = getCars()
    @Binding var carData:[CarDB]
    
    var body: some View {
        //NavigationView {
            List(carData) {
                    car in NavigationLink {
                        CarDetail(carList: $carData, car: car)
                    } label: {
                        CarRow(car: car)
                    }
            }.navigationTitle("Car list")
        //}
    }
}

struct CarList_Previews: PreviewProvider {
    @State static var carList: [CarDB] = getCars()
    static var previews: some View {
        CarList(carData: $carList)
    }
}
