This project is an assignment I had to make for a company.
The goal was to implement the flickr API by making an app that allows the user to retrieve and swipe through a gallery of pictures from Flickr.
In this case, the app searchs for the "Birthday" term.
The requirements were to not use the official Flickr Objective C API and to not use storyboards nor nib.

It's my first app developped while not using storyboard.


FEATURES
- Retrieve Flickr pictures with tag 
- Can scroll through gallery of pictures
- Can view details of pictures : Bigger Picture + Title
- Can swipe back from DetailsView to go back to GalleryView
- iOS7 and higher support
- Network activity verification at launch
- Loading pictures 10 per request because Flickr API is kinda slow, and also helps for people with slow connexion
- Button at end of gallery to load 10 more pictures
- «SearchTerm » and « ItemPerPage » can be modified at the top of their respective related files


CAN BE ADDED BUT DID NOT 
- AlertView regarding network activity 
- Accessing gallery pictures from DetailsView (The gallery data is already send too the DetailsViewController), horizontal scroll like Apple Photos app
-  More design
- App Icon
- LaunchScreen
