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
#import <FBSDKCoreKit/FBSDKProfile.h>
#import <FBSDKLoginKit/FBSDKLoginManager.h>
#import <Toast/Toast.h>

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
    [self setupTable];
    [self setToolbar];
    [self getFacebookInfo];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.lessonListTable reloadData];
}

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiGreenColor];
    
    self.lessonListTable.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.title = @"Lessons";
    
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
    
    [self performSegueWithIdentifier:@"showmap" sender:nil];
    
    NSLog(@"Map Icon Pressed");
}

- (void)didSelectUserSettingsIcon {
    
    [self.view makeToast:@"Feature coming soon!" duration:1.5 position:CSToastPositionCenter];
    NSLog(@"User Settings Icon Pressed");
    
}

- (void)didSelectSearchIcon {
    
    [self.view makeToast:@"Feature coming soon!" duration:1.5 position:CSToastPositionCenter];
    NSLog(@"Search Icon Pressed");
    
}

- (void)didSelectLikeIcon {
    
    [self.view makeToast:@"Feature coming soon!" duration:1.5 position:CSToastPositionCenter];
    NSLog(@"Like Icon Pressed");
    
}

- (void)didSelectCalendarIcon {
    
    [self.view makeToast:@"Feature coming soon!" duration:1.5 position:CSToastPositionCenter];
    NSLog(@"Calendar Icon Pressed");
    
}

- (void)didSelectNotificationIcon {
    
    [self.view makeToast:@"Feature coming soon!" duration:1.5 position:CSToastPositionCenter];
    NSLog(@"Alert Icon Pressed");
    
}

- (void)didSelectUserIcon {
    
    [self performSegueWithIdentifier:@"showuser" sender:nil];
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

#pragma mark - Facebook

- (void)getFacebookInfo {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [FBSDKProfile loadCurrentProfileWithCompletion:^(FBSDKProfile *profile, NSError *error) {
            if (profile) {
                
                NSURL * userImageURL = [profile imageURLForPictureMode:FBSDKProfilePictureModeSquare size:CGSizeMake(35, 35)];
                NSData * userImageData = [NSData dataWithContentsOfURL:userImageURL];
                
                NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                
                [userDefaults setObject:profile.name forKey:@"user-name"];
                [userDefaults setObject:userImageData forKey:@"user-image-data"];
                
                UIImage * userImage = [UIImage imageWithData:userImageData];
                
                UIImageView * userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
                
                userImageView.image = userImage;
                
                UIView * leftNavBarItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
                
                
                leftNavBarItemView.layer.cornerRadius = leftNavBarItemView.frame.size.width / 2;
                
                leftNavBarItemView.clipsToBounds = YES;
                
                leftNavBarItemView.userInteractionEnabled = YES;
                
                [leftNavBarItemView addSubview:userImageView];
                
                UITapGestureRecognizer * logoutTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapLogout)];
                
                [leftNavBarItemView addGestureRecognizer:logoutTap];
                
                UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftNavBarItemView];
                
                self.navigationItem.leftBarButtonItem = leftButton;
                
                
            }
        }];
    });
}

- (void)didTapLogout {
    
    /*
    
    FBSDKLoginManager * fbManager = [[FBSDKLoginManager alloc] init];
    
    [fbManager logOut];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    UIStoryboard * loginBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:loginBoard.instantiateInitialViewController];
    
    UIImageView * backButtonImageView = [UIImageView getNavBarImageViewForIcon:@"back"];
    
    UIView * backButtonItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    
    [backButtonItemView addSubview:backButtonImageView];
    
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonItemView];
    
    navController.navigationItem.backBarButtonItem = backButtonItem;
     
     
    [self dismissViewControllerAnimated:YES completion:nil];
     
     */
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
