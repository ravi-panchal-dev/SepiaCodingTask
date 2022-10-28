//
//  AppUtility.swift
//  Sepia Test
//
//  Created by iOS on 28/10/22.
//

import Foundation

class AppUtility {
    
    static let shared = AppUtility()
    
    func getWorkingHours() -> String {
        
        if let path = Bundle.main.path(forResource: jsonConfigFile, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let settings = jsonResult["settings"] as? [String : Any] {
                    return "\(settings["workHours"]!)"
                }
                
            } catch {
                return " "
            }
        }
        return " "
    }
}

