//
//  TeacherAlertsViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 02/01/2019.
//  Copyright © 2019 Ahmed Ali Zafar. All rights reserved.
//

#import "TeacherAlertsViewController.h"
#import "UIColor+Wisekai.h"
#import "UIView+Wisekai.h"
#import "UIImageView+WiseKai.h"

#import "APICalls.h"

@interface TeacherAlertsViewController ()

@end

@implementation TeacherAlertsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayout];
    [self setNavBar];
    [self setToolbar];
}

- (void)viewDidAppear:(BOOL)animated {
    [self getNotificationDataFromAPI];
}

#pragma mark - Helpers

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
    
    //self.activityIndicatorView.alpha = 0.0;
}

- (void)setNavBar {
    
    self.navigationItem.title = @"Notifications";
    
    //Set Font
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:17.0],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = size;
    
    //Set Color
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor wiseKaiRedColor],NSForegroundColorAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    //Set Back Button
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(popViewControllerAnimated:)];
    
    backButton.tintColor = [UIColor wiseKaiDarkGrayColor];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    
}

- (void)setToolbar {
    
    /*
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
    
    */
    //Set up Notification Icon
    UITapGestureRecognizer * notificationTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectNotificationIcon)];
    
    UIView * notificationView = [UIView getNavBarIconView];
    
    [notificationView addGestureRecognizer:notificationTap];
    
    UIImageView * currentTab = [UIImageView getTeacherToolbarImageViewForIcon:@"toolbar-alert"];
    
    currentTab.tintColor = [UIColor wiseKaiRedColor];
    
    [notificationView addSubview:currentTab];
    
    UIBarButtonItem * notificationBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationView];
    
    
    /*
    //Set up User Icon
    UITapGestureRecognizer * userTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectUserIcon)];
    
    UIView * userView = [UIView getNavBarIconView];
    
    [userView addGestureRecognizer:userTap];
    
    [userView addSubview:[UIImageView getNavBarImageViewForIcon:@"toolbar-user"]];
    
    UIBarButtonItem * userBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:userView];
    
    UIBarButtonItem * flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //self.bottomToolbar.items = @[searchBarButtonItem, flexibleSpace,likeBarButtonItem,flexibleSpace, calendarBarButtonItem,flexibleSpace, notificationBarButtonItem,flexibleSpace, userBarButtonItem];
    */
    UIBarButtonItem * flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.teacherToolbar.items = @[flexibleSpace, notificationBarButtonItem, flexibleSpace];
    
}

#pragma mark - Navigation

- (void)segueToNotifications {
    [self performSegueWithIdentifier:@"showalerts" sender:nil];
}

- (void)segueToProfile {
    
}

# pragma mark - API Calls

- (void)getNotificationDataFromAPI {
    
    [APICalls getNotifications:^(NSData * _Nonnull responseData) {
        NSLog(@"Stude received");
    }];
    
}

@end
