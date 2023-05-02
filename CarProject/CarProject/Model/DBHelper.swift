//
//  DBHelper.swift
//  CarProject
//
//  Created by GABRIEL PALAFOX SUAREZ on 26/04/23.
//

import Foundation
import SQLite3

class DBHelper {
    var db : OpaquePointer?
    var path : String = "db_car5.sqlite"
    init() {
        self.db = createDB()
        self.createTable()
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("There is error in creating DB")
            return nil
        }else {
            print("Database is been created with path \(path)")
            return db
        }
    }
    
    func createTable() {
        let query = "CREATE TABLE IF NOT EXISTS cars(id INTEGER PRIMARY KEY AUTOINCREMENT, brand TEXT NOT NULL, model TEXT NOT NULL, motor TEXT NOT NULL, imageName TEXT NOT NULL, price INTEGER NOT NULL, kilometraje TEXT NOT NULL, garantia TEXT NOT NUll, country TEXT NO NULL);"
        
        var createTable: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &createTable, nil) == SQLITE_OK {
            if sqlite3_step(createTable) == SQLITE_DONE {
                print("Table creation success")
            }else {
                print("Table creation fail")
            }
        }else {
            print("Prepation fail")
        }
    }
    
    func insertCar(brand: String, model: String, motor: String, imageName: String, price: Int32, kilometraje: String, garantia: String, country: String) {
        let query = "INSERT INTO cars VALUES (NULL,?,?,?,?,?,?,?,?)"
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            
            // sqlite3_bind_int(statement, 1, 2)
            sqlite3_bind_text(statement, 1, (brand as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (model as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (motor as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (imageName as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 5, price)
            sqlite3_bind_text(statement, 6, (kilometraje as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 7, (garantia as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 8, (country as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Data insertes success")
            }else {
                print("Data is not inserted in table")
            }
            
        }else {
            print("Query is not as per requirement")
        }
    }
    
    func findCars() -> [CarDB] {
        let query = "SELECT * FROM cars"
        var statement: OpaquePointer? = nil
        var mainList = [CarDB]()
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                
                let id = Int(sqlite3_column_int(statement, 0))
                let brand = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                let model = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                let motor = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                let imageName = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                let price = Int32(sqlite3_column_int(statement, 5))
                let kilometraje = String(describing: String(cString: sqlite3_column_text(statement, 6)))
                let garantia = String(describing: String(cString: sqlite3_column_text(statement, 7)))
                let country = String(describing: String(cString: sqlite3_column_text(statement, 8)))
                
                var modelDB = CarDB()
                modelDB.id = id
                modelDB.brand = brand
                modelDB.model = model
                modelDB.motor = motor
                modelDB.imageName = imageName
                modelDB.price = price
                modelDB.kilometraje = kilometraje
                modelDB.garantia = garantia
                modelDB.country = country
                
                
                mainList.append(modelDB)
            }
         }else {
            print("Query is not as per requirement")
        }
        
        return mainList
        
    }
    
    func deleteCar(id: Int) {
        let query = "DELETE FROM cars WHERE id = \(id)"
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Data delete success")
            }else {
                print("Data is not deleted in table")
            }
        }else {
            print("Query is not as per requirement")
        }
    }
    
    
}
