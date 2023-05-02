//
//  AditionCarView.swift
//  CarProject
//
//  Created by GABRIEL PALAFOX SUAREZ on 26/04/23.
//

import SwiftUI

struct AditionCarView: View {
    
    enum CarImages: String, CaseIterable, Identifiable {
        case M1, BMWM4, BMWM4GT4, AUDI, FERRARI
        var id: Self {self}
    }
    
    enum CarGarantia: String, CaseIterable, Identifiable {
        case LIMITED, UNLIMITED, EXPIRED
        var id: Self {self}
    }
    
    enum CarCountry: String, CaseIterable, Identifiable {
        case mexico, bolivia, spain, usa, germany
        var id: Self {self}
    }
    
    @Binding var carList: [CarDB]
    @State private var brand: String = ""
    @State private var model: String = ""
    @State private var motor: String = ""
    @State private var price: String = ""
    @State private var imageName: CarImages = .M1
    @State private var kilometraje: String = "0"
    @State private var garantia: CarGarantia = .LIMITED
    @State private var country: CarCountry = .mexico
    
    @State private var statusText: String = ""
    
    func handleCreation(brand: String, model: String, motor: String, imageName: String, price: String, kilometraje: String, garantia: String, country: String) {
        
        statusText = ""
        
        if brand == "" || model == "" || motor == "" || price == "" {
            statusText = "Empty values"
            return
        }
        
        if let intPrice = Int32(price) {
            addCar(brand: brand, model: model, motor: motor, imageName: imageName, price: intPrice, kilometraje: kilometraje, garantia: garantia, country: country)
            carList = getCars()
            statusText = "Car added!"
        } else {
            statusText = "Can not add this price"
            return
        }
        
    }
    
    func printSelected() {
        print(imageName)
    }
    
    
    var body: some View {
        Form {
            Section(header: Text("Add new Car")) {
                TextField("Brand", text: $brand)
                TextField("Model", text: $model)
                TextField("Motor", text: $motor)
                TextField("Price", text: $price)
                Picker("Image name", selection: $imageName) {
                    Text("M1").tag(CarImages.M1)
                    Text("BMWM4").tag(CarImages.BMWM4)
                    Text("BMWM4GT4").tag(CarImages.BMWM4GT4)
                    Text("AUDI").tag(CarImages.AUDI)
                    Text("FERRARI").tag(CarImages.FERRARI)
                }
                Picker("Warranty", selection: $garantia) {
                    Text("Limited").tag(CarGarantia.LIMITED)
                    Text("Unlimited").tag(CarGarantia.UNLIMITED)
                    Text("Expired").tag(CarGarantia.EXPIRED)
                }
                Picker("Country", selection: $country) {
                    Text("Mexico").tag(CarCountry.mexico)
                    Text("Bolivia").tag(CarCountry.bolivia)
                    Text("USA").tag(CarCountry.usa)
                    Text("Spain").tag(CarCountry.spain)
                    Text("Germany").tag(CarCountry.germany)
                    
                }
                
            }
            HStack(spacing: 50) {
                Text(statusText)
                Spacer()
                Button("Add") {
                    handleCreation(brand: brand, model: model, motor: motor, imageName: imageName.rawValue, price: price, kilometraje: kilometraje, garantia: garantia.rawValue, country: country.rawValue)
                }
            }
        }
    }
}

struct AditionCarView_Previews: PreviewProvider {
    @State static var carList: [CarDB] = getCars()
    static var previews: some View {
        AditionCarView(carList: $carList)
    }
}
