//
//  FlickrAPI.swift
//  EversnapAssignment
//
//  Created by sophie hoarau on 20/01/2016.
//  Copyright © 2016 StephenHoarau. All rights reserved.
//

import UIKit
import Foundation

//Model class to do the bridge with FlickrAPI

class FlickrAPI {
    
    private let apiKey : String = "57c1048118b3205096717b183ffe9b5e"
    private let itemPerPage = 10
    
    func flickerGetPicture(farm: String, id: String, server: String, secret: String, size: String) -> UIImage { //Build URL and Load Image from specific picture
        
        let string : String = "https://farm\(farm).staticflickr.com/\(server)/" + id + "_" + secret + "_" + size + ".jpg"
    
        let image = NSData(contentsOfURL: NSURL(string: string)!)
        
        return UIImage(data: image!)!
    }
    
    func flickrSearch(term : String, page: Int, completionHandler: (result: [Photo]?, error: NSError?) -> Void) { // retrieve pictures, 10pictures per requests
        
        var photoArray = [Photo]()
        let baseURL = "https://api.flickr.com/services/rest/?&method=flickr.photos.search"
        let apiString = "&api_key=\(self.apiKey)"
        let searchString = "&tags=birthdays&format=json&nojsoncallback=1&per_page=\(self.itemPerPage)&page=" + String(page)
        
        
        let requestURL = NSURL(string: baseURL + apiString + searchString)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(requestURL!, completionHandler: { data, response, error -> Void in

            if (data == nil) {
                let APIError = NSError(domain: "RequestError", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Network issue"])
                completionHandler(result: nil, error: APIError)
            }
            
            do {
                
                let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary
                switch (result!["stat"] as! String) {
                case "ok":
                    let photos : NSArray = result?.objectForKey("photos")?.objectForKey("photo") as! NSArray
                    
                    for photo in photos {
                        let item = photo as! NSDictionary
                        let farm = String(item.objectForKey("farm") as! Int)
                        let server = item.objectForKey("server") as! String
                        let id = item.objectForKey("id") as! String
                        let secret = item.objectForKey("secret") as! String
                        let title = item.objectForKey("title") as! String
                        
                        let photo = Photo(secret: secret, farm: farm, server: server, id: id, description: title)
                        photo.setThumbnail(self.flickerGetPicture(farm, id: id, server: server, secret: secret, size: "m"))
                        photoArray.append(photo)
                    }
                    
                    completionHandler(result: photoArray, error: nil)
                case "fail":
                    let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:result!["message"]!])
                    completionHandler(result: nil, error: APIError)
                    return
                default:
                    let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown error JSON"])
                    completionHandler(result: nil, error: APIError)
                    return
                }

            } catch {
                print(error)
            }
        })
        task.resume()
    }
    
    
}
