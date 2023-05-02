//
//  CarDetail.swift
//  CarProject
//
//  Created by GABRIEL PALAFOX SUAREZ on 25/04/23.
//

import SwiftUI
import MapKit

struct CarDetail: View {
    @Binding var carList: [CarDB]
    @State private var delation: Bool = false
    @State private var delationText: String = ""
    var car: CarDB
    
    func deleteCurrentCar(id: Int) {
        removeCar(id: id)
        carList = getCars()
        delationText = "Car deleted!"
    }
    
    func getCountry(country: String) -> String {
        let api = CountryApi(country: country)
        let result = api.getAll()
        // print(result)
        
        let name: String! = result.name
        let capital: String! = result.capital
        let region: String! = result.region
        return "\(capital!), \(name!) (\(region!))"
    }
    
    var body: some View {
        NavigationView {
            VStack (spacing: 20) {
                HStack {
                    Text("Marca:")
                    Text(car.brand ?? "No Brand")
                }
                HStack {
                    Text("Modelo:")
                    Text(car.model ?? "No Model")
                }
                HStack {
                    Text("Motor:")
                    Text(car.motor ?? "No Motor")
                }
                HStack {
                    Text(getCountry(country: car.country ?? "Mexico"))
                }
                Image(car.imageName ?? "NOCARIMG").resizable().frame(width: 250, height: 150)
                // car.image.resizable().frame(width: 250, height: 150)
                Button("Delete") {
                    deleteCurrentCar(id: car.id)
                }
                // Text(delationText)
                NavigationLink("Go Map") {
                    MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
                }

            }
        }
    }
}

struct CarDetail_Previews: PreviewProvider {
    static var carList0: [CarDB] = getCars()
    @State static var carList: [CarDB] = getCars()
    static var previews: some View {
        CarDetail(carList: $carList,car: carList0[0])
    }
}
