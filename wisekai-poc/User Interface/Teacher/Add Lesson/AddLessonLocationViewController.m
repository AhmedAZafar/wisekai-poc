//
//  AddLessonLocationViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 31/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "AddLessonLocationViewController.h"
#import "UIColor+Wisekai.h"

#import <Toast/Toast.h>


@interface AddLessonLocationViewController () {
    CLLocationCoordinate2D lessonCoords;
}

@end

@implementation AddLessonLocationViewController

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLayout];
    [self setNavbar];
    [self prepareMap];
}

- (void)viewDidAppear:(BOOL)animated {
    [self setMapInitialLocation];
}

- (void)viewWillDisappear:(BOOL)animated {
    //[delegate passDataToLessonDetails:selectedLocationPlacemark];
}

#pragma mark - Helpers

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
    
    self.infoLabel.backgroundColor = [UIColor clearColor];
    
}

- (void)setNavbar {
    
    self.navigationItem.title = @"Select location";
    
    //Set Font
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:17.0],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = size;
    
    //Set Color
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor wiseKaiRedColor],NSForegroundColorAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(popViewControllerAnimated:)];
    
    backButton.tintColor = [UIColor wiseKaiDarkGrayColor];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem * selectButton = [[UIBarButtonItem alloc] initWithTitle:@"Set" style:UIBarButtonItemStyleDone target:self action:@selector(didPressSelectOnNavbar)];
    
    selectButton.tintColor = [UIColor wiseKaiDarkGrayColor];
    
    self.navigationItem.rightBarButtonItem = selectButton;
    
}


# pragma mark - Map Setup & Delegate

- (void)setMapInitialLocation {
    
    
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(25.204849, 55.270782);
    
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(startCoord, 5000, 5000) animated:YES];
    
}


- (void)prepareMap {

    
    
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressOnMap:)];
    longPress.minimumPressDuration = 2.0;
    [self.mapView addGestureRecognizer:longPress];
}

- (void)handleLongPressOnMap:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
    annot.coordinate = touchMapCoordinate;
    lessonCoords = annot.coordinate;
    [self.mapView addAnnotation:annot];
    

}


#pragma mark - IBActions

- (void)didPressSelectOnNavbar {
    
    if (self.mapView.annotations.count != 0 && CLLocationCoordinate2DIsValid(lessonCoords)) {
        
        NSString * longitude = [NSString stringWithFormat:@"%.15f", lessonCoords.longitude];
        NSString * latitude = [NSString stringWithFormat:@"%.15f", lessonCoords.latitude];
        
        CLGeocoder * geocoder = [[CLGeocoder alloc] init];
        CLLocation * selectedLocation = [[CLLocation alloc] initWithLatitude:lessonCoords.latitude longitude:lessonCoords.longitude];
        
        __block CLPlacemark * placemark;
        __block NSString *strAdd = nil;
        [geocoder reverseGeocodeLocation:selectedLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
            
            
            if (error == nil && [placemarks count] > 0)
            {
                placemark = [placemarks lastObject];
                
                // strAdd -> take bydefault value nil
                
                
                if ([placemark.subThoroughfare length] != 0) {
                    strAdd = placemark.subThoroughfare;
                    NSLog(@"SubThoroughFare: %@", placemark.subThoroughfare);
                }
                
                
                if ([placemark.thoroughfare length] != 0)
                {
                    NSLog(@"Thoroughfare: %@", placemark.thoroughfare);
                    // strAdd -> store value of current location
                    if ([strAdd length] != 0)
                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark thoroughfare]];
                    else
                    {
                        // strAdd -> store only this value,which is not null
                        strAdd = placemark.thoroughfare;
                    }
                }
                
                
                if ([placemark.postalCode length] != 0)
                {
                    NSLog(@"Postal Code: %@", placemark.postalCode);
                    if ([strAdd length] != 0)
                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark postalCode]];
                    else
                        strAdd = placemark.postalCode;
                }
                
                if ([placemark.locality length] != 0)
                {
                    NSLog(@"locaity: %@", placemark.locality);
                    if ([strAdd length] != 0)
                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark locality]];
                    else
                        strAdd = placemark.locality;
                }
                
                if ([placemark.administrativeArea length] != 0)
                {
                    NSLog(@"AdminArea: %@", placemark.administrativeArea);
                    if ([strAdd length] != 0)
                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark administrativeArea]];
                    else
                        strAdd = placemark.administrativeArea;
                }
                 
                
                if ([placemark.country length] != 0)
                {
                    NSLog(@"Country: %@", placemark.country);
                    if ([strAdd length] != 0)
                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark country]];
                    else
                        strAdd = placemark.country;
                }
                
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:longitude forKey:@"lesson-longitude"];
            [[NSUserDefaults standardUserDefaults] setObject:latitude forKey:@"lesson-latitude"];
            
            if (placemark != nil) {
                
                NSString * number = placemark.subThoroughfare;
                NSString * street = placemark.thoroughfare;
                NSString * city = placemark.locality;
                
                NSMutableDictionary * placeMarkDict = [[NSMutableDictionary alloc] init];
                
                if (number.length > 0) {
                    
                    [placeMarkDict setObject:number forKey:@"number"];
                    
                }
                
                if (street.length > 0) {
                    [placeMarkDict setObject:street forKey:@"street"];
                }
                
                if (city.length > 0) {
                    [placeMarkDict setObject:city forKey:@"city"];
                }
                
                
                [[NSUserDefaults standardUserDefaults] setObject:placeMarkDict forKey:@"lesson-placemark"];
                
            } else {
                
                
                
                NSLog(@"No PLace mark found");
            }
            
            
            
            [self.view makeToast:@"Location set" duration:10.0 position:CSToastPositionCenter];
            
            [self.view makeToast:@"Location set" duration:0.7 position:CSToastPositionCenter title:@"Success!" image:nil style:nil completion:^(BOOL didTap) {
                if (didTap) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        }];   
    } else {
        [self.view makeToast:@"Please select a location" duration:1.0 position:CSToastPositionCenter];
    }
}

@end
