//
//  SignUpInterestViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 29/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "SignUpInterestViewController.h"
#import "UIColor+Wisekai.h"
#import <Toast/Toast.h>
#import "APICalls.h"

@interface SignUpInterestViewController ()

@end

@implementation SignUpInterestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayout];
    [self setNavbar];
    [self setTextfields];
    
    
}

#pragma mark - Helpers

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
    
    [self.signUpButton setBackgroundColor:[UIColor wiseKaiGreenColor]];
    [self.signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.signUpButton.layer.cornerRadius = self.signUpButton.frame.size.height / 2;
    self.signUpButton.clipsToBounds = YES;
    
}

- (void)setNavbar {
    
    self.navigationItem.title = @"Interests";
    
    //Set Font
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:17.0],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = size;
    
    //Set Color
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor wiseKaiGreenColor],NSForegroundColorAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(popViewControllerAnimated:)];
    
    backButton.tintColor = [UIColor wiseKaiDarkGrayColor];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
}

- (void)setTextfields {
    
    [self setTextFieldBorder:self.primaryInterestTextfield];
    [self setTextFieldBorder:self.secondaryInterestTextfield];
    [self setTextFieldBorder:self.tertiaryInterestTextfield];
    
    self.primaryInterestTextfield.delegate = self;
    self.secondaryInterestTextfield.delegate = self;
    self.tertiaryInterestTextfield.delegate = self;
    
    
    self.primaryInterestTextfield.returnKeyType = UIReturnKeyDone;
    self.secondaryInterestTextfield.returnKeyType = UIReturnKeyDone;
    self.tertiaryInterestTextfield.returnKeyType = UIReturnKeyDone;
    
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

- (IBAction)didSelectSignUp:(id)sender {
    
    if ([self validateTextfields]) {
        [self updatePersistenceStore];
        
        [APICalls createStudent:^void (NSData * _Nonnull responseData) {
            
            NSError * readError;
            
            NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&readError];
            
            NSLog(@"Response: %@", responseDict);
            
            if ([responseDict objectForKey:@"value"] != nil) {
                
                
                [[NSUserDefaults standardUserDefaults] setObject:responseDict[@"value"] forKey:@"bearer-token"];
                
                [self performSegueWithIdentifier:@"studenthome" sender:nil];
                
            } else {
                [self.view makeToast:@"Server failed to process request. Please try again later or contact system admin" duration:2.5 position:CSToastPositionCenter];
            }
            
        }];
        
        
    }
    

}

#pragma mark - UITextfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Textfield Validator

- (BOOL)validateTextfields {
    
    if ((self.primaryInterestTextfield.text.length > 0) &&
        (self.secondaryInterestTextfield.text.length > 0) &&
        (self.tertiaryInterestTextfield.text.length > 0)){
        
        return true;
        
    } else {
        
        return false;
    }
    
}


#pragma mark - Persistence Store

- (void)updatePersistenceStore {
    
    NSDictionary * lesson = @{
                              
                              @"user-interest-one":self.primaryInterestTextfield.text,
                              @"user-interest-two":self.secondaryInterestTextfield.text,
                              @"user-interest-three":self.tertiaryInterestTextfield.text
                              
                              };
    
    [[NSUserDefaults standardUserDefaults] setObject:lesson forKey:@"user-interests"];
}


@end
