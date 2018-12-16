//
//  SignInViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 13/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "SignInViewController.h"
#import "UIColor+Wisekai.h"
#import "HomeViewController.h"

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
    
    /*if ((self.emailTextfield.text && self.emailTextfield.text.length > 0) && (self.passwordTextfield.text && self.passwordTextfield.text.length > 0))  {
        
        HomeViewController * homeVC = [[HomeViewController alloc] init];
        
        homeVC.userEmail = [NSString stringWithString:self.emailTextfield.text];
        homeVC.userPassword = [NSString stringWithString:self.passwordTextfield.text];
        
        [self.navigationController pushViewController:homeVC animated:YES];
        
    }*/
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



@end
