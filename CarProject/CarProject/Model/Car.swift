//
//  Car.swift
//  CarProject
//
//  Created by GABRIEL PALAFOX SUAREZ on 25/04/23.
//

import Foundation
import SwiftUI
import CoreLocation

struct Car: Hashable, Codable, Identifiable{
    var id: Int
    var brand: String
    var model: String
    var motor: String
    
    private var imageName: String
    var  image: Image {
        Image(imageName)
    }
}

struct CarDB: Codable, Identifiable {
    var id: Int = 1
    var brand: String? = nil
    var model: String? = nil
    var motor: String? = nil
    var imageName: String? = nil
    var price: Int32? = nil
    var kilometraje: String? = nil
    var garantia: String? = nil
    var country: String? = nil
}
