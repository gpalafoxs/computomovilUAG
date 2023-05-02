//
//  CarController.swift
//  CarProject
//
//  Created by GABRIEL PALAFOX SUAREZ on 26/04/23.
//

import Foundation

var db = DBHelper()

func addCar(brand:String, model: String, motor: String, imageName: String, price: Int32, kilometraje: String, garantia: String, country: String) {
    db.insertCar(brand: brand, model: model, motor: motor, imageName: imageName, price: price, kilometraje: kilometraje, garantia: garantia, country: country)
}

func getCars() -> [CarDB] {
    print("Getting cars")
    let carsList = db.findCars()
    return carsList
}

func createTable() {
    db = DBHelper()
}

func removeCar(id: Int) {
    db.deleteCar(id: id)
}
