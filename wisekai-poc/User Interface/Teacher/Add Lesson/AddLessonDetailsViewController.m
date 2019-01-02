//
//  AddLessonDetailsViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 30/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "AddLessonDetailsViewController.h"
#import "UIColor+Wisekai.h"
#import "APICalls.h"

#import <XLForm/XLForm.h>
#import <CoreLocation/CoreLocation.h>
#import <Toast/Toast.h>
#import <DownPicker/DownPicker.h>

@interface AddLessonDetailsViewController () {
    DownPicker * lessonDayPicker;
    UIDatePicker * lessonStartTimePicker;
}

@end

@implementation AddLessonDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[[self tableView] registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"headerFooterReuseIdentifier"];
    [self setLayout];
    [self setNavbar];
    [self setPickers];
    [self setKeyboardToolbar];
    [self setMapNavigation];
    
    NSDictionary * newDict = [[NSUserDefaults standardUserDefaults] valueForKey:@"new-lesson"];
    
    NSLog(@"New Lesson is: %@", newDict);
    
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.activityIndicatorView.alpha = 0.0;
    
    self.createLessonButton.userInteractionEnabled = YES;
    
    [self checkIfLocationSet];
    
    //[self checkLocationPermission];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
   // [self checkLocationPermission];
    
}


#pragma mark - Helpers
- (void)setLayout {
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
    
    [self.createLessonButton setBackgroundColor:[UIColor wiseKaiRedColor]];
    [self.createLessonButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.createLessonButton.layer.cornerRadius = self.createLessonButton.frame.size.height / 2;
    self.createLessonButton.clipsToBounds = YES;
    
    [self setTextFieldBorder:self.lessonDayTextfield];
    [self setTextFieldBorder:self.startTimeTextfield];
    [self setTextFieldBorder:self.lessonTagOeTextfield];
    [self setTextFieldBorder:self.lessonTagTwoTextfield];
    [self setTextFieldBorder:self.lessonTagThreeTextfield];
    
    self.lessonDayTextfield.delegate = self;
    self.startTimeTextfield.delegate = self;
    self.lessonTagOeTextfield.delegate = self;
    self.lessonTagTwoTextfield.delegate = self;
    self.lessonTagThreeTextfield.delegate = self;
    
}

- (void)setNavbar {
    
    self.navigationItem.title = @"Lesson schedule";
    
    //Set Font
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:17.0],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = size;
    
    //Set Color
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor wiseKaiRedColor],NSForegroundColorAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(popViewControllerAnimated:)];
    
    backButton.tintColor = [UIColor wiseKaiDarkGrayColor];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
}

- (void)setPickers {
    NSMutableArray * dayArray = [[NSMutableArray alloc] init];
    [dayArray addObject:@"Monday"];
    [dayArray addObject:@"Tuesday"];
    [dayArray addObject:@"Wednesday"];
    [dayArray addObject:@"Thursday"];
    [dayArray addObject:@"Friday"];
    [dayArray addObject:@"Saturday"];
    [dayArray addObject:@"Sunday"];
    
    lessonDayPicker = [[DownPicker alloc] initWithTextField:self.lessonDayTextfield withData:dayArray];
    [lessonDayPicker setPlaceholder:@"Tap to choose day of the week *"];
    
    lessonStartTimePicker = [[UIDatePicker alloc] init];
    
    lessonStartTimePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [lessonStartTimePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.startTimeTextfield.inputView = lessonStartTimePicker;
    
}

- (void)setKeyboardToolbar {
    
    UIToolbar * keyboardToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    keyboardToolbar.items = [NSArray arrayWithObjects: [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(donePicking)],nil];
    [keyboardToolbar sizeToFit];
    self.startTimeTextfield.inputAccessoryView = keyboardToolbar;
}

- (void)donePicking{
    [self.view endEditing:YES];
}

- (void)datePickerValueChanged:(id)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    self.startTimeTextfield.text = [dateFormatter stringFromDate:lessonStartTimePicker.date];
}


- (void)setMapNavigation {
    
    UITapGestureRecognizer * tapOnLocationLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectChooseLocationLabel)];
    
    tapOnLocationLabel.numberOfTapsRequired = 1;
    
    [self.lessonLocationLabel addGestureRecognizer:tapOnLocationLabel];
    [self.lessonLocationLabel setUserInteractionEnabled:YES];
    
}

- (void)setTextFieldBorder :(UITextField *)textField{
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1.0;
    border.borderColor = [UIColor grayColor].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;
    
}



#pragma mark - IBActions

- (void)didSelectChooseLocationLabel {
    [self performSegueWithIdentifier:@"lessonlocation" sender:nil];
}

- (IBAction)didSelectCreateLessonButton:(id)sender {
    
    if ([self validateTextfields]) {
        
        self.createLessonButton.userInteractionEnabled = NO;
        
        [self updatePersistenceStore];
        
        self.view.alpha = 0.5;
        self.activityIndicatorView.alpha = 1.0;
        
        [self.activityIndicatorView startAnimating];
        
        
        NSLog(@"Lesson Schedule: %@", [[NSUserDefaults standardUserDefaults] valueForKey:@"new-lesson-schedule"]);
        
        
        [APICalls createLesson:^(NSData * _Nonnull responseData) {
            
            NSError * readError;
            
            NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&readError];
            
            NSLog(@"Response: %@", responseDict);
            
            [self.activityIndicatorView stopAnimating];
            self.activityIndicatorView.alpha = 0.0;
            self.view.alpha = 1.0;
            
            if ([responseDict[@"value"] isEqualToString:@"SUCCESS"]) {
                [self.view makeToast:@"You successfully created new lesson" duration:10.3 position:CSToastPositionCenter title:@"Success!" image:[UIImage imageNamed:@"tick"] style:nil completion:^(BOOL didTap) {
                    if (didTap) {
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
                
            } else {
                [self.view makeToast:@"Server failed to respond in time. Try again Later" duration:10.0 position:CSToastPositionCenter];
            }
            
            
            
        }];
        
    } else {
        
        self.createLessonButton.userInteractionEnabled = YES;
        
        [self.view makeToast:@"Please fill all fields" duration:1.3 position:CSToastPositionCenter];
        
        
    }
    
    
    
    
    
}
- (void)didSelectCreateLesson {
    /*
    NSLog(@"Did select createBar Button");
    
    NSDictionary * formDict = [NSDictionary dictionaryWithDictionary:self.formValues];
    
    NSLog(@"form : %@", formDict);*/
}
/*
#pragma mark - CLLocation

- (void)checkLocationPermission {
    if ([locationManager locationServicesEnabled]) {
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
            
            NSLog(@"Location Access Granted");
            [locationManager startUpdatingLocation];
            
            
        } else {
            [locationManager requestWhenInUseAuthorization];
        }
        
        
        
    } else {
        [self.view makeToast:@"Location Services Disabled. Please enable them in your settings menu." duration:2.0 position:CSToastPositionCenter];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    [manager stopUpdatingLocation];
    
    currentLocation = [manager location];
    
    NSLog(@"Locations found : %@", locations);
    
}
 */

#pragma mark - Textfield Validator

- (BOOL)validateTextfields {
    
    if ((self.lessonDayTextfield.text.length > 0) &&
        (self.lessonTagOeTextfield.text.length > 0) &&
        (self.lessonTagTwoTextfield.text.length > 0) &&
        (self.lessonTagThreeTextfield.text.length > 0.0)){
        
        return true;
        
    } else {
        
        return false;
    }
    
}


#pragma mark - Persistence Store

- (void)updatePersistenceStore {
    
    NSDictionary * lesson = @{
                              
                              @"lesson-day":self.lessonDayTextfield.text,
                              @"leson-time":self.startTimeTextfield.text,
                              @"lesson-tag-one":self.lessonTagOeTextfield.text,
                              @"lesson-tag-two":self.lessonTagTwoTextfield.text,
                              @"lesson-tag-three":self.lessonTagThreeTextfield.text
                              
                              };
    
    [[NSUserDefaults standardUserDefaults] setObject:lesson forKey:@"new-lesson-schedule"];
}

- (void)checkIfLocationSet {
    NSDictionary * placemarkDict = [[NSUserDefaults standardUserDefaults] valueForKey:@"lesson-placemark"];
    
    
    
    
    if (placemarkDict.count == 0) {
        self.lessonLocationLabel.text = @"Tap to choose lesson location *";
    }else {
        NSString * street = placemarkDict[@"street"];
        NSString * number = placemarkDict[@"number"];
        NSString * city = placemarkDict[@"city"];
        
        NSString * addressString = [[NSString alloc] init];
        
        
        if (number.length > 0) {
            addressString = [NSString stringWithFormat:@"%@", number];
        }
        
        if (street.length > 0) {
            addressString = [NSString stringWithFormat:@"%@ %@", addressString,street];
        }
        
        if (city.length > 0) {
            addressString = [NSString stringWithFormat:@"%@ %@", addressString, city];
        }
        
        
        addressString = [addressString stringByAppendingString:@" (Tap to set another)"];
        
        
        self.lessonLocationLabel.text = addressString;
    }
}

@end
