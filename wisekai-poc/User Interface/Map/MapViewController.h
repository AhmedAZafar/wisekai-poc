//
//  MapViewController.h
//  wisekai-poc
//
//  Created by Ahmed Ali Zafar on 19/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet MKMapView *lessonMapView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@end

NS_ASSUME_NONNULL_END
