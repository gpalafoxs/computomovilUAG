//
//  Country.swift
//  CarProject
//
//  Created by GABRIEL PALAFOX SUAREZ on 28/04/23.
//

import Foundation
import SwiftUI
import CoreLocation

struct Country: Codable, Identifiable {
    var id: Int = 0
    var name: String? = nil
    var capital: String? = nil
    var region: String? = nil
}
