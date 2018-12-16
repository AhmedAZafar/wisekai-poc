//
//  HomeViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 13/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "UIColor+Wisekai.h"

#import <FBSDKCoreKit/FBSDKProfile.h>
#import <FBSDKLoginKit/FBSDKLoginManager.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayout];
    [self setNavBar];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [FBSDKProfile loadCurrentProfileWithCompletion:^(FBSDKProfile *profile, NSError *error) {
            if (profile) {
                self.navigationItem.title = [NSString stringWithFormat:@"%@", profile.name];
                
                NSURL * userImageURL = [profile imageURLForPictureMode:FBSDKProfilePictureModeSquare size:CGSizeMake(35, 35)];
                
                UIImage * userImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:userImageURL]];
                
                UIImageView * userImageView = [[UIImageView alloc] initWithImage:userImage];
                
                UIView * profileView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
                
                profileView.layer.cornerRadius = profileView.frame.size.width / 2;
                profileView.clipsToBounds = YES;
                
                profileView.userInteractionEnabled = YES;
                
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapProfileView)];
                
                [profileView addGestureRecognizer:tap];
                
                [profileView addSubview:userImageView];
                
                UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:profileView];
                
                self.navigationItem.leftBarButtonItem = barButton;
            }
        }];
    });
    
    
    
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
    [self.navigationController.navigationBar setTintColor:[UIColor wiseKaiCreamColor]];
}


#pragma mark - Gesture Recognizer

- (void)didTapProfileView {
    
    FBSDKLoginManager * fbManager = [[FBSDKLoginManager alloc] init];
    
    [fbManager logOut];
    
    LoginViewController * loginVC = [[LoginViewController alloc] init];
    
    [self presentViewController:loginVC animated:YES completion:nil];
}


#pragma mark - SearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}


@end
