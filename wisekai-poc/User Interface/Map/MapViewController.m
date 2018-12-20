//
//  MapViewController.m
//  wisekai-poc
//
//  Created by Ahmed Ali Zafar on 19/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "MapViewController.h"
#import "UIColor+Wisekai.h"
#import "UIImageView+WiseKai.h"
#import "UIView+Wisekai.h"

#import <Toast/Toast.h>

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayout];
    [self setNavBar];
    [self setToolbar];
}

#pragma mark - Helpers

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
    
    self.searchBar.delegate = self;
    
    self.searchBar.layer.borderWidth = 1.0;
    self.searchBar.layer.borderColor = [[UIColor wiseKaiCreamColor] CGColor];
    
    
    self.searchBar.tintColor = [UIColor wiseKaiCreamColor];
    
    self.searchBar.backgroundImage = [UIImage new];
    [self.searchBar setTranslucent:YES];
    
    self.searchBar.backgroundColor = [UIColor wiseKaiCreamColor];
    
    
    [self.toolBar setTintColor:[UIColor wiseKaiDarkGrayColor]];
    
    
}

- (void)setNavBar {
    [self.navigationController.navigationBar setTintColor:[UIColor wiseKaiDarkGrayColor]];
    /*
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(popViewControllerAnimated:)];
    */
    self.navigationItem.backBarButtonItem.title = @"";
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
    
    self.toolBar.items = @[searchBarButtonItem, flexibleSpace,likeBarButtonItem,flexibleSpace, calendarBarButtonItem,flexibleSpace, notificationBarButtonItem,flexibleSpace, userBarButtonItem];
}


#pragma mark - Gesture Recognizer

- (void)didTapProfileView {
    
    //FBSDKLoginManager * fbManager = [[FBSDKLoginManager alloc] init];
    
    //[fbManager logOut];
    
    //LoginViewController * loginVC = [[LoginViewController alloc] init];
    
    //[self presentViewController:loginVC animated:YES completion:nil];
}

- (void)didSelectMapIcon {
    
    [self performSegueWithIdentifier:@"showmap" sender:nil];
    
    NSLog(@"Map Icon Pressed");
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
    
    //FBSDKLoginManager * fbManager = [[FBSDKLoginManager alloc] init];
    
    //[fbManager logOut];
    
    //UIStoryboard * loginBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    
    //UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:loginBoard.instantiateInitialViewController];
    
    //navController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //[self presentViewController:navController animated:YES completion:nil];
}


#pragma mark - SearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}


@end
