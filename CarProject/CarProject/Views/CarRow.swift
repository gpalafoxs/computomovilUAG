//
//  CarRow.swift
//  CarProject
//
//  Created by GABRIEL PALAFOX SUAREZ on 25/04/23.
//

import SwiftUI

struct CarRow: View {
    
    var car: CarDB
    
    func getPrice(price: Int32) -> String {
        let stringPrice = String(price)
        return stringPrice
        
    }
    
    var body: some View {
        HStack{
            Image(car.imageName ?? "NOCAR").resizable().frame(width: 70, height: 50)
            //car.image.resizable().frame(width: 70, height: 50)
            VStack {
                Text(car.brand ?? "No Brand")
                Text(car.model ?? "No Model")
            }
            Spacer()
            HStack{
                Text("$")
                Text(getPrice(price: car.price!))
            }
        }.padding()
    }
}

struct CarRow_Previews: PreviewProvider {
    static var carList: [CarDB] = getCars()
    static var previews: some View {
        Group {
            CarRow(car: carList[0])
        }.previewLayout(.fixed(width: 300, height: 70))
    }
}
