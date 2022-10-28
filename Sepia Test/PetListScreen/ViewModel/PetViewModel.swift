//
//  PetViewModel.swift
//  Sepia Test
//
//  Created by iOS on 28/10/22.
//

import UIKit

class PetViewModel: NSObject {
    
    var arrPetList: [PetModel] = [PetModel]()
    
    func getPetData() {
        if let path = Bundle.main.path(forResource: jsonPetsListFile, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = result as? Dictionary<String, AnyObject>, let objPets = jsonResult["pets"] as? [Any] {
                    for data in objPets {
                        let arrPet = PetModel(petData: data as! [String : Any] )
                        arrPetList.append(arrPet)
                    }
                }
            } catch {
                //if any error so please handle here
            }
        }
    }
    
}
