//
//  APIHelper.swift
//  CarProject
//
//  Created by GABRIEL PALAFOX SUAREZ on 28/04/23.
//

import Foundation

class CountryApi {
    
    var country: String
    
    init(country: String) {
        self.country = country
    }
    
    func getAll() -> Country {
        
        var modelDB = Country()
        
        let url = URL(string: "https://restcountries.com/v2/name/\(self.country)")
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        var data: Data?
        var responseError: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = session.dataTask(with: request) { (responseData, urlResponse, error) in
            data = responseData
            responseError = error
            semaphore.signal()
        }
        
        task.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        if let error = responseError {
            print("Error making request: \(error.localizedDescription)")
        } else if let responseData = data {
            do {
                if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [[String: Any]] {
                    for country in json {
                        
                        if let name = country["name"] as? String,
                        let capital = country["capital"] as? String,
                           let region = country["region"] as? String {
                            
                            modelDB.name = name
                            modelDB.capital = capital
                            modelDB.region = region
                            
                        }
                        
                        
                        
                    }
                }
            } catch let error as NSError {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        return modelDB
        
    }
    
}
