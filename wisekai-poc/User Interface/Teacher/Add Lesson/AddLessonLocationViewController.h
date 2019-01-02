//
//  AddLessonLocationViewController.h
//  wisekai-poc
//
//  Created by Ahmed on 31/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>




NS_ASSUME_NONNULL_BEGIN

//Protocol to pass placemark back to Lesson detail
@protocol wisekaiPlacemarkPortocol <NSObject>

-(void)passDataToLessonDetails:(CLPlacemark *)placemark;

@end

@interface AddLessonLocationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (assign, nonatomic) id<wisekaiPlacemarkPortocol>delegate;

@end



NS_ASSUME_NONNULL_END
