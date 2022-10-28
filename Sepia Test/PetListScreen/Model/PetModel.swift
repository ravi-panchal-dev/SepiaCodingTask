//
//  PetsModel.swift
//  Sepia Test
//
//  Created by iOS on 28/10/22.
//

import Foundation

class PetModel {
    
    var imgURL: String?
    var title: String?
    var wikiURL: String?
    var dateAdded: String?
    
    init(petData:[String : Any]){
        
        self.imgURL = petData["image_url"] as? String
        self.title = petData["title"] as? String
        self.wikiURL = petData["content_url"] as? String
        self.dateAdded = petData["date_added"] as? String
        
    }
}
