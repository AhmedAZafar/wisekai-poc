//
//  SignUpPersonalDetailsViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 29/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "SignUpPersonalDetailsViewController.h"
#import "UIColor+Wisekai.h"
#import <Toast/Toast.h>
#import <DownPicker/DownPicker.h>

@interface SignUpPersonalDetailsViewController () {
    UIDatePicker * dobPicker;
    
    NSArray * genderArray;
    DownPicker * genderDownPicker;
}

@end

@implementation SignUpPersonalDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavbar];
    [self setLayout];
    [self setKeyboardToolbar];
    [self setDatePicker];
    [self setGenderPicker];
    [self setTextfields];
    
    genderArray = [NSArray arrayWithObjects:@"Male", @"Female", nil];
    
}

#pragma mark - Helpers

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
    
    [self.nextButton setBackgroundColor:[UIColor wiseKaiGreenColor]];
    [self.nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.nextButton.layer.cornerRadius = self.nextButton.frame.size.height / 2;
    self.nextButton.clipsToBounds = YES;
    
}

- (void)setNavbar {
    
    self.navigationItem.title = @"Personal details";
    
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

- (void)setKeyboardToolbar {
    
    UIToolbar * keyboardToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    keyboardToolbar.items = [NSArray arrayWithObjects: [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(donePicking)],nil];
    [keyboardToolbar sizeToFit];
    self.genderTextfield.inputAccessoryView = keyboardToolbar;
    self.dobTextfield.inputAccessoryView = keyboardToolbar;
}

-(void)donePicking{
    [self.view endEditing:YES];
}

- (void)setDatePicker {
    
    dobPicker = [[UIDatePicker alloc] init];
    
    dobPicker.datePickerMode = UIDatePickerModeDate;
    
    [dobPicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.dobTextfield setInputView:dobPicker];
}

- (void)setGenderPicker {
    
    NSMutableArray * genderArray = [[NSMutableArray alloc] init];
    
    [genderArray addObject:@"Male"];
    [genderArray addObject:@"Female"];
    
    genderDownPicker = [[DownPicker alloc] initWithTextField:self.genderTextfield withData:genderArray];
    
    
}

- (void)setTextfields {
    
    [self setTextFieldBorder:self.firstNameTextfield];
    [self setTextFieldBorder:self.lastNameTextfield];
    [self setTextFieldBorder:self.genderTextfield];
    [self setTextFieldBorder:self.dobTextfield];
    [self setTextFieldBorder:self.phoneNumberTextfield];
    
    self.firstNameTextfield.delegate = self;
    self.lastNameTextfield.delegate = self;
    self.genderTextfield.delegate = self;
    self.dobTextfield.delegate = self;
    self.phoneNumberTextfield.delegate = self;
    
    self.firstNameTextfield.returnKeyType = UIReturnKeyDone;
    self.lastNameTextfield.returnKeyType = UIReturnKeyDone;
    self.genderTextfield.returnKeyType = UIReturnKeyDone;
    self.dobTextfield.returnKeyType = UIReturnKeyDone;
    self.phoneNumberTextfield.returnKeyType = UIReturnKeyDone;
    
}


- (void)datePickerValueChanged:(id)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM dd yyyy"];
    self.dobTextfield.text = [self getUTCFormateDate:dobPicker.date];
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

-(NSString *)getUTCFormateDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

#pragma mark - IBActions

- (IBAction)didSelectNext:(id)sender {
    
    if ((self.firstNameTextfield.text && self.firstNameTextfield.text.length > 0) &&
        (self.lastNameTextfield.text && self.lastNameTextfield.text.length > 0) &&
        (self.genderTextfield.text && self.genderTextfield.text.length > 0) &&
        (self.dobTextfield.text && self.dobTextfield.text.length > 0) &&
        (self.phoneNumberTextfield.text && self.phoneNumberTextfield.text.length > 0)) {
        
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        
        [userDefaults setObject:self.firstNameTextfield.text forKey:@"user-firstname"];
        [userDefaults setObject:self.lastNameTextfield.text forKey:@"user-lastname"];
        [userDefaults setObject:self.genderTextfield.text forKey:@"user-gender"];
        [userDefaults setObject:self.dobTextfield.text forKey:@"user-dob"];
        [userDefaults setObject:self.phoneNumberTextfield.text forKey:@"user-phone"];
        
        
        NSString * userType = (NSString *)[userDefaults objectForKey:@"user-type"];
        
        if ([userType isEqualToString:@"student"]) {
            [self performSegueWithIdentifier:@"signupinterests" sender:nil];
        } else {
            [self performSegueWithIdentifier:@"signupqualifications" sender:nil];
        }
    } else {
        [self.view makeToast:@"Please fill all mandatory fields" duration:1.7 position:CSToastPositionCenter];
    }
}


#pragma mark - UITextfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - PickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [genderArray objectAtIndex:row];
}


@end
