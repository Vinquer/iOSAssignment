//
//  Photo.swift
//  EversnapAssignment
//
//  Created by sophie hoarau on 20/01/2016.
//  Copyright © 2016 StephenHoarau. All rights reserved.
//

import Foundation
import UIKit

// Model Class for the Photo item
// Multiple init class depending of required use

class Photo {
    
    var url : String = ""
    var description : String = ""
    var secret : String = ""
    var farm : String = ""
    var id : String = ""
    var server: String = ""
    
    var thumbnailImage = UIImage?()
    var largeImage = UIImage?()
    var largeImageSet: Bool = false
        

    init(url: String, description: String) {
        self.url = url
        self.description = description
    }
    
    init(secret: String, farm: String, server: String, id: String, description:String) {
        self.secret = secret
        self.farm = farm
        self.server = server
        self.id = id
        self.description = description
    }
    
    func setThumbnail(image: UIImage) {
        self.thumbnailImage = image
    }
    
    func setLargeImage(image: UIImage) {
        self.largeImage = image
    }
}