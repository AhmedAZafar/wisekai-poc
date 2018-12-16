//
//  SignUpViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 12/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "SignUpViewController.h"
#import "UIColor+Wisekai.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavbar];
    [self setLayout];
    [self setupTextfields];

}

#pragma mark - IBActions

- (IBAction)didPressSignUpButton:(id)sender {
}


#pragma mark - Helpers

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
    
    [self.signupButton setBackgroundColor:[UIColor wiseKaiGreenColor]];
    [self.signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.signupButton.layer.cornerRadius = self.signupButton.frame.size.height / 2;
    self.signupButton.clipsToBounds = YES;
    
    self.footerTextview.backgroundColor = [UIColor clearColor];
    self.footerTextview.textColor = [UIColor wiseKaiCreamyGrayColor];
    
}

- (void)setNavbar {
    
    self.navigationItem.title = @"Sign Up";
    
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

- (void)setupTextfields {
    
    [self setTextFieldBorder:self.nameTextField];
    [self setTextFieldBorder:self.passwordTextField];
    [self setTextFieldBorder:self.emailTextField];
    [self setTextFieldBorder:self.repeatPasswordTextfield];
    
    self.passwordTextField.secureTextEntry = YES;
    self.repeatPasswordTextfield.secureTextEntry = YES;
    
    self.nameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.repeatPasswordTextfield.delegate = self;
    
    self.emailTextField.returnKeyType = UIReturnKeyDone;
    self.passwordTextField.returnKeyType = UIReturnKeyDone;
    self.repeatPasswordTextfield.returnKeyType = UIReturnKeyDone;
    self.nameTextField.returnKeyType = UIReturnKeyDone;
    
}

-(void)setTextFieldBorder :(UITextField *)textField{
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1.0;
    border.borderColor = [UIColor grayColor].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;
    
}


#pragma mark - Textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
