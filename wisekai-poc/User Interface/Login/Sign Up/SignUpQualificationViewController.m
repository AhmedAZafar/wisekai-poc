//
//  SignUpQualificationViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 29/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "SignUpQualificationViewController.h"
#import "UIColor+Wisekai.h"

#import "APICalls.h"


@interface SignUpQualificationViewController ()

@end

@implementation SignUpQualificationViewController

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
    
    self.navigationItem.title = @"Qualifications";
    
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
    
    [self setTextFieldBorder:self.mandatoryQualificationTextfield];
    [self setTextFieldBorder:self.secondaryQualificationTextfield];
    [self setTextFieldBorder:self.tertiaryQualificationTextfield];
    
    self.mandatoryQualificationTextfield.delegate = self;
    self.secondaryQualificationTextfield.delegate = self;
    self.tertiaryQualificationTextfield.delegate = self;
    
    
    self.mandatoryQualificationTextfield.returnKeyType = UIReturnKeyDone;
    self.secondaryQualificationTextfield.returnKeyType = UIReturnKeyDone;
    self.tertiaryQualificationTextfield.returnKeyType = UIReturnKeyDone;
    
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
    
    [APICalls createTeacher:^void (NSData * _Nonnull responseData) {
        
        NSError * readError;
        
        NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&readError];
        
        NSLog(@"Response: %@", responseDict);
        
        [[NSUserDefaults standardUserDefaults] setObject:responseDict[@"value"] forKey:@"bearer-token"];
    }];
    
    
    
}

#pragma mark - UITextfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
