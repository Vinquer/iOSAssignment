//
//  ViewController.swift
//  EversnapAssignment
//
//  Created by sophie hoarau on 20/01/2016.
//  Copyright © 2016 StephenHoarau. All rights reserved.
//

import UIKit

//MainView

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var photoArray : [Photo] = [Photo]()
    var page : Int = 1                                                  // Index page for the flickr request
    let flickr : FlickrAPI = FlickrAPI()                                //FlickrAPI class that deals with the requests and setup
    let searchTerm = "Birthday"
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    var textLabel = UILabel()
    var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Gallery"
        
        activityIndicator.center = view.center
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width / 3 - 2, height: view.frame.size.width / 3 - 2) // Minus value is here to match the minimumInteritemSpacing value
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 5
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView!.registerClass(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.whiteColor()
        
        self.textLabel = UILabel(frame: CGRect(x: view.center.x - 100, y: view.center.y - 15, width: 200, height: 30))
        self.textLabel.font = UIFont.boldSystemFontOfSize(15)
        self.textLabel.textAlignment = .Center
        self.textLabel.textColor = .blackColor()
        self.textLabel.text = "Network is unavailable"

        
        
        self.view.addSubview(collectionView)
        self.view.addSubview(activityIndicator)
        self.view.addSubview(self.textLabel)

        self.activityIndicator.startAnimating()


        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        let network = NetworkCheck()
        //add If no network ->  UIAlertViewController/View
        while (!network.connectedToNetwork()) {
        }
        self.textLabel.removeFromSuperview()
        if (self.page == 1) {
            self.searchFlickrForTerm(self.searchTerm, page: self.page)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchFlickrForTerm(term: String, page: Int) { //retrieve gallery and save it in array
        
        self.flickr.flickrSearch(term, page: page) { result, error in
            
            if (error != nil) {
                print("Error while searching: \(error)")
            }
            
            if (result != nil) {
                self.photoArray = result!
                dispatch_async(dispatch_get_main_queue()) {
                    self.collectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func loadMoreFlickrPictures() { //call FlickrAPI bridge to specifically request next page of picture
        self.activityIndicator.startAnimating()
        self.activityIndicator.color = .whiteColor()
        ++self.page
        self.flickr.flickrSearch(self.searchTerm, page: self.page) { result, error in
            
            if (error != nil) {
                print("Error while searching: \(error)")
            }
            
            if (result != nil) {
                
                let array : [Photo] = result!

                for photo in  array {
                    self.photoArray.append(photo)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.collectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    //Delegate collectionview
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoArray.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
                
        if (indexPath.row == self.photoArray.count) {
            self.loadMoreFlickrPictures()
            return
        }
        
            let detailsViewController = DetailsViewController()
        
            detailsViewController.arrayPhotos = self.photoArray  //send all gallery for potential use of swipping through all the gallery in details view
            detailsViewController.tappedIndex = indexPath.row //index of picture tapped to show the related picture
            detailsViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        
            self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        
        if (self.photoArray.count > indexPath.row) {
           let photo = self.photoArray[indexPath.row]
            cell.imageView.image = photo.thumbnailImage
            cell.imageView.clipsToBounds = true
        } else if (indexPath.row == self.photoArray.count && self.photoArray.count > 0 ) { //add '+' button to load more "pages" of content
            cell.imageView.image = UIImage(named: "loadMoreIcon")
        }
        return cell
    }
}

