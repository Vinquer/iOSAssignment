//
//  DetailsViewController.swift
//  EversnapAssignment
//
//  Created by sophie hoarau on 20/01/2016.
//  Copyright © 2016 StephenHoarau. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    var arrayPhotos : [Photo] = [Photo]()
    var tappedIndex : Int!
    var imageView : UIImageView!
    var textLabel : UILabel!
    
    var flickr = FlickrAPI()
    
    override func viewDidLoad() { // init navigationbaritem, imageview and label for details
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()
        self.navigationController?.interactivePopGestureRecognizer?.enabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let btnName = UIButton()
        btnName.setImage(UIImage(named: "backIcon"), forState: .Normal)
        btnName.frame = CGRectMake(0, 0, 30, 30)
        btnName.addTarget(self, action: Selector("returnToGallery"), forControlEvents: .TouchUpInside)
        
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnName
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.title = "Details"
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: view.bounds.size.height*4/5))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        imageView.backgroundColor = .grayColor()
        
        // Display the picture that was selected from the gallery array and check if has already been loaded once
        
        
        let photo = self.arrayPhotos[self.tappedIndex]
        if (photo.largeImage == nil) {
            photo.setLargeImage(flickr.flickerGetPicture(photo.farm, id: photo.id, server: photo.server, secret: photo.secret, size: "b"))
        }
        
        imageView.image = photo.largeImage
        view.addSubview(imageView)
        textLabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.size.height, width: view.bounds.size.width, height: view.bounds.size.height/5 - 20))
        textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        textLabel.textAlignment = .Center
        textLabel.textColor = .blackColor()
        textLabel.font = UIFont.boldSystemFontOfSize(15)
        textLabel.text = photo.description
        view.addSubview(textLabel)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func returnToGallery() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
