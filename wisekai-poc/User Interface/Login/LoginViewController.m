//
//  LoginViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 19/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "LoginViewController.h"

#import "UIColor+Wisekai.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLayout];
}

#pragma mark  - IBActions

- (IBAction)didSelectSignInButton:(id)sender {
    [self performSegueWithIdentifier:@"signin" sender:nil];
}
- (IBAction)didSelectSignUpButton:(id)sender {
    [self performSegueWithIdentifier:@"signup" sender:nil];
}

#pragma mark  - Helpers

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
    
    [self.signInButton setBackgroundColor:[UIColor wiseKaiCreamColor]];
    [self.signUpButton setBackgroundColor:[UIColor wiseKaiCreamColor]];
    
    [self.signInButton setTitleColor:[UIColor wiseKaiDarkGrayColor] forState:UIControlStateNormal];
    [self.signUpButton setTitleColor:[UIColor wiseKaiDarkGrayColor] forState:UIControlStateNormal];
    
    [self.termsConditionsTextview setBackgroundColor:[UIColor clearColor]];
    [self.termsConditionsTextview setTextColor:[UIColor wiseKaiCreamyGrayColor]];
    
    [self setFacebookLogin];
}

- (void)setFacebookLogin {
    FBSDKLoginButton * fbLoginButton = [[FBSDKLoginButton alloc] initWithFrame:CGRectMake(0, 0, 240.0, 30.0)];
    
    fbLoginButton.delegate = self;
    fbLoginButton.center = self.view.center;
    fbLoginButton.readPermissions = @[@"public_profile", @"email"];
    
    [self.view addSubview:fbLoginButton];
}


#pragma mark - FacebookSDKLoginButtonDelegateMethods

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }
    
    if (result.isCancelled) {
        NSLog(@"User cancelled the login");
    } else if (result.declinedPermissions.count > 0) {
        NSLog(@"Permissions Declined"); // Navigate to back to Sign IN Screen
    } else {
        //Take User to Home View Controler
        
        
        
        
        UIStoryboard * studentStoryBoard = [UIStoryboard storyboardWithName:@"Student" bundle:nil];
        
        [self presentViewController:studentStoryBoard.instantiateInitialViewController animated:YES completion:nil];
    }
    
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    NSLog(@"User logged out");
}

@end
