//
//  SignInViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 19/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "SignInViewController.h"
#import "UIColor+Wisekai.h"
#import <Toast/Toast.h>

#import "APICalls.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayout];
    [self setNavBar];
    [self setupTextfields];
}


#pragma mark - IBActions

- (IBAction)didPressLoginButton:(id)sender {
    
    [CSToastManager setTapToDismissEnabled:YES];
    [CSToastManager setQueueEnabled:NO];
    if ((self.emailTextfield && self.emailTextfield.text.length > 0) && (self.passwordTextfield && self.passwordTextfield.text.length > 0)) {
        
        [[NSUserDefaults standardUserDefaults] setObject:self.emailTextfield.text forKey:@"user-email"];
        [[NSUserDefaults standardUserDefaults] setObject:self.passwordTextfield.text forKey:@"user-password"];
        
        [APICalls loginUser:^(NSData * _Nonnull responseData) {
            
            NSError * readError;
            
            NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&readError];
            
            NSLog(@"Response: %@", responseDict);
            
            if(responseDict[@"value"] != nil) {
                
                [[NSUserDefaults standardUserDefaults] setObject:responseDict[@"value"] forKey:@"bearer-token"];
                
                [[NSUserDefaults standardUserDefaults] setObject:@"teacher" forKey:@"user-type"];
                
                NSString * userType = (NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:@"user-type"];
                
                if ([userType isEqualToString:@"teacher"]) {
                    [self presentTeacherStoryboard];
                } else if ([userType isEqualToString:@"student"]) {
                    [self presentStudentStoryboard];
                } else {
                    
                    [APICalls getParty:^(NSData * _Nonnull responseData) {
                        
                        NSError * readError;
                        
                        NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&readError];
                        
                        NSLog(@"Response Dictionary for Anonym User is: %@", responseDict);
                        
                    }];
                    
                    [self.navigationController popToRootViewControllerAnimated:NO];
                }
                
            } else {
                NSLog(@"Errro : %@", responseDict);
                #warning HANDLE ERROR HERE - ALERT FOR MVP
            }
        }];
        
        //[self.view makeToast:@"Login Successful" duration:2.0 position:CSToastPositionCenter];
    }else if (self.emailTextfield.text.length <= 0){
        [self.view makeToast:@"Please enter your email address" duration:2.0 position:CSToastPositionCenter];
    } else {
        [self.view makeToast:@"Please enter your password" duration:2.0 position:CSToastPositionCenter];
    }
    
}


#pragma mark - Helpers

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
    
    [self.loginButton setBackgroundColor:[UIColor wiseKaiOrangeColor]];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.loginButton.layer.cornerRadius = self.loginButton.frame.size.height / 2;
    self.loginButton.clipsToBounds = YES;
}

- (void)setNavBar {
    //Set Title Text
    self.navigationItem.title = @"Login";
    
    //Set Font
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:17.0],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = size;
    
    //Set Color
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor wiseKaiOrangeColor],NSForegroundColorAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    //Set Back Button
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(popViewControllerAnimated:)];
    
    backButton.tintColor = [UIColor wiseKaiDarkGrayColor];
    
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void) setupTextfields {
    
    [self setTextFieldBorder:self.emailTextfield];
    [self setTextFieldBorder:self.passwordTextfield];
    
    self.emailTextfield.returnKeyType = UIReturnKeyDone;
    self.passwordTextfield.returnKeyType = UIReturnKeyDone;
    
    [self.passwordTextfield setSecureTextEntry:YES];
    
    self.emailTextfield.delegate = self;
    self.passwordTextfield.delegate = self;
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

#pragma mark - UITextfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Navigation

- (void)presentStudentStoryboard {
    
    UIStoryboard * studentBoard = [UIStoryboard storyboardWithName:@"Student" bundle:nil];
    [self presentViewController:studentBoard.instantiateInitialViewController animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
}


- (void)presentTeacherStoryboard {
    
    UIStoryboard * teacherBoard = [UIStoryboard storyboardWithName:@"Teacher" bundle:nil];
    [self presentViewController:teacherBoard.instantiateInitialViewController animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

@end
