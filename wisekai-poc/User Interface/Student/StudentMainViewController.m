//
//  StudentMainViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 16/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "StudentMainViewController.h"
#import "UIImageView+WiseKai.h"
#import "UIView+Wisekai.h"
#import "UIColor+Wisekai.h"
#import "Lesson List/LessonCell.h"
#import "Lesson/LessonViewController.h"

#import <UserNotifications/UserNotifications.h>
#import <FBSDKLoginKit/FBSDKLoginManager.h>

@interface StudentMainViewController ()
{
    NSArray * lessonTitleArray;
    NSArray * lessonDescriptionArray;
    NSArray * lessonImageArray;
    NSArray * lessonColorArray;
    
    NSString * selectedLessonTitle;
    NSString * selectedLessonDescription;
    NSString * selectedLessonImageName;
}

@end

@implementation StudentMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayout];
    [self setNavBar];
    [self registerForNotifications];
    [self setupTable];
    [self setToolbar];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.lessonListTable reloadData];
}

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiGreenColor];
    
    self.lessonListTable.backgroundColor = [UIColor clearColor];
    
}


- (void)setNavBar {
    
    //Set up Map Icon
    UITapGestureRecognizer * mapTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectMapIcon)];
    
    UIView * mapView = [UIView getNavBarIconView];
    
    [mapView addGestureRecognizer:mapTap];
    
    [mapView addSubview:[UIImageView getNavBarImageViewForIcon:@"navbar-map"]];
    
    UIBarButtonItem * mapBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mapView];
    
    // Set up User Settings Icon
    
    UITapGestureRecognizer * userSettingsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectUserSettingsIcon)];
    
    UIView * userSettingsView = [UIView getNavBarIconView];
    
    [userSettingsView addGestureRecognizer:userSettingsTap];
    
    [userSettingsView addSubview:[UIImageView getNavBarImageViewForIcon:@"navbar-usersettings"]];
    
    UIBarButtonItem * userSettingsBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:userSettingsView];
    
    // Adding Icons to NavBar
    self.navigationItem.rightBarButtonItems = @[mapBarButtonItem, userSettingsBarButtonItem];
    
    
    
}

- (void) setupTable {
    lessonTitleArray = [[NSArray alloc] initWithObjects:@"Computer Programming", @"English Language", @"Learn Guitar", @"Painting Today", nil];
    lessonDescriptionArray = [[NSArray alloc] initWithObjects:@"Sharpen your computer skills", @"Learn english today!", @"Dig in your soul? Learn an instrument today", @"Be an Artist! Painting lessons now available", nil];
    lessonImageArray = [[NSArray alloc] initWithObjects:@"table-computer", @"table-english", @"table-music", @"table-painting", nil];
    lessonColorArray = [[NSArray alloc] initWithObjects:@"wiseKaiLightBlueColor", @"wiseKaiBlueColor", @"wiseKaiDarkPurpleColor", @"wiseKaiMarronColor", nil];
    
    self.lessonListTable.delegate = self;
    self.lessonListTable.dataSource = self;
    
    [self.lessonListTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)setToolbar {
    //Set up Search Icon
    UITapGestureRecognizer * searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectSearchIcon)];
    
    UIView * searchView = [UIView getNavBarIconView];
    
    [searchView addGestureRecognizer:searchTap];
    
    [searchView addSubview:[UIImageView getNavBarImageViewForIcon:@"toolbar-search"]];
    
    UIBarButtonItem * searchBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchView];

    
    //Set up Like Icon
    UITapGestureRecognizer * likeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectLikeIcon)];
    
    UIView * likeView = [UIView getNavBarIconView];
    
    [likeView addGestureRecognizer:likeTap];
    
    [likeView addSubview:[UIImageView getNavBarImageViewForIcon:@"toolbar-like"]];
    
    UIBarButtonItem * likeBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:likeView];
    
    //Set up Calendar Icon
    UITapGestureRecognizer * calendarTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectCalendarIcon)];
    
    UIView * calendarView = [UIView getNavBarIconView];
    
    [calendarView addGestureRecognizer:calendarTap];
    
    [calendarView addSubview:[UIImageView getNavBarImageViewForIcon:@"toolbar-calendar"]];
    
    UIBarButtonItem * calendarBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:calendarView];
    
    
    //Set up Notification Icon
    UITapGestureRecognizer * notificationTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectNotificationIcon)];
    
    UIView * notificationView = [UIView getNavBarIconView];
    
    [notificationView addGestureRecognizer:notificationTap];
    
    [notificationView addSubview:[UIImageView getNavBarImageViewForIcon:@"toolbar-alert"]];
    
    UIBarButtonItem * notificationBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationView];
    
    
    
    //Set up User Icon
    UITapGestureRecognizer * userTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectUserIcon)];

    UIView * userView = [UIView getNavBarIconView];
    
    [userView addGestureRecognizer:userTap];
    
    [userView addSubview:[UIImageView getNavBarImageViewForIcon:@"toolbar-user"]];
    
    UIBarButtonItem * userBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:userView];
    
    UIBarButtonItem * flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.bottomToolbar.items = @[searchBarButtonItem, flexibleSpace,likeBarButtonItem,flexibleSpace, calendarBarButtonItem,flexibleSpace, notificationBarButtonItem,flexibleSpace, userBarButtonItem];
}

#pragma mark - Tap Gesture Callback Selectors

- (void)didSelectMapIcon {
    
    NSLog(@"Map Icon Pressed");
}

- (void)didSelectUserSettingsIcon {
    
    NSLog(@"User Settings Icon Pressed");
    
}

- (void)didSelectSearchIcon {
    
    NSLog(@"Search Icon Pressed");
    
}

- (void)didSelectLikeIcon {
    
    NSLog(@"Like Icon Pressed");
    
}

- (void)didSelectCalendarIcon {
    
    NSLog(@"Calendar Icon Pressed");
    
}

- (void)didSelectNotificationIcon {
    
    NSLog(@"Alert Icon Pressed");
    
}

- (void)didSelectUserIcon {
    
    FBSDKLoginManager * fbManager = [[FBSDKLoginManager alloc] init];
    
    [fbManager logOut];
    
    UIStoryboard * loginBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:loginBoard.instantiateInitialViewController];
    
    navController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self presentViewController:navController animated:YES completion:nil];
}


#pragma mark - Push Notifications


- (void)registerForNotifications {
    
    UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
    
    if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
        NSLog(@"Application already registered");
    } else {
        
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"Permission Given");
                //[application registerForRemoteNotifications];
            } else {
                NSLog(@"Permission Not given");
            }
        }];
        
        UIApplication * currentApp = [UIApplication sharedApplication];
        
        [currentApp registerForRemoteNotifications];
        
    }
}


#pragma mark - TableView Delegate Callbacks


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    LessonCell * lessonTVC = [self.lessonListTable dequeueReusableCellWithIdentifier:@"LessonCell"];
    
    if (!lessonTVC) {
        [self.lessonListTable registerNib:[UINib nibWithNibName:@"LessonCell" bundle:nil] forCellReuseIdentifier:@"LessonCell"];
        lessonTVC = [self.lessonListTable dequeueReusableCellWithIdentifier:@"LessonCell"];
    }
    
    lessonTVC.lessonTitleLabel.text = [lessonTitleArray objectAtIndex:indexPath.row];
    lessonTVC.lessonDescriptionLabel.text = [lessonDescriptionArray objectAtIndex:indexPath.row];
    lessonTVC.lessonImageView.image = [[UIImage imageNamed:[lessonImageArray objectAtIndex:indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    lessonTVC.lessonImageView.tintColor = [UIColor whiteColor];
    
    NSString * currentColorName = [lessonColorArray objectAtIndex:indexPath.row];
    
    if ([currentColorName isEqualToString:@"wiseKaiLightBlueColor"]) {
        
        lessonTVC.backgroundColor = [UIColor wiseKaiLightBlueColor];
        
    } else if ([currentColorName isEqualToString:@"wiseKaiBlueColor"]){
        
        lessonTVC.backgroundColor = [UIColor wiseKaiBlueColor];
        
    } else if ([currentColorName isEqualToString:@"wiseKaiDarkPurpleColor"]) {
        
        lessonTVC.backgroundColor = [UIColor wiseKaiDarkPurpleColor];
        
    } else if ([currentColorName isEqualToString:@"wiseKaiMarronColor"]) {
        
        lessonTVC.backgroundColor = [UIColor wiseKaiMarronColor];
        
    } else {
        
        lessonTVC.backgroundColor = [UIColor wiseKaiCreamColor];
    }
    
    
    
    return lessonTVC;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return lessonTitleArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    selectedLessonTitle = [[NSString alloc] initWithString:[lessonTitleArray objectAtIndex:indexPath.row]];
    selectedLessonDescription = [[NSString alloc] initWithString:[lessonDescriptionArray objectAtIndex:indexPath.row]];
    selectedLessonImageName = [[NSString alloc] initWithString:[lessonImageArray objectAtIndex:indexPath.row]];
    
    [self performSegueWithIdentifier:@"showlesson" sender:nil];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[LessonViewController class]]) {
        LessonViewController * lessonVC = segue.destinationViewController;
        
        lessonVC.lessonName = selectedLessonTitle;
        lessonVC.lessonDescription = selectedLessonDescription;
        lessonVC.lessonImageName = selectedLessonImageName;
    }
}


@end
