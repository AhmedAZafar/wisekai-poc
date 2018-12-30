//
//  UserSelectionViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 11/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "UserSelectionViewController.h"
#import "UIColor+Wisekai.h"
#import "UIImageView+WiseKai.h"

#import <Toast/Toast.h>

@interface UserSelectionViewController ()

@end

@implementation UserSelectionViewController


- (void)viewWillAppear:(BOOL)animated {
    [self setLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - IBActions

- (IBAction)didSelectTeacherButton:(id)sender {
    //[self.view makeToast:@"Feature Under Development" duration:3.0 position:CSToastPositionCenter];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:@"teacher" forKey:@"user-type"];
    
    [self performSegueWithIdentifier:@"showlogin" sender:nil];
}
- (IBAction)didSelectStudentButton:(id)sender {
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:@"student" forKey:@"user-type"];
    
    [self performSegueWithIdentifier:@"showlogin" sender:nil];
}
- (IBAction)didSelectExisitngAccountButton:(id)sender {
    [self performSegueWithIdentifier:@"showloginsignin" sender:nil];
}

#pragma mark - Helpers

- (void)setLayout {
    self.view.backgroundColor = [UIColor wiseKaiDarkPurpleColor];
    
    self.teacherButton.backgroundColor = [UIColor wiseKaiPinkColor];
    [self roundButton:self.teacherButton];
    
    self.studentButton.backgroundColor = [UIColor wiseKaiGreenColor];
    [self roundButton:self.studentButton];
    
    self.existingAccountButton.backgroundColor = [UIColor wiseKaiDarkPurpleColor];
    self.existingAccountButton.layer.cornerRadius = self.existingAccountButton.frame.size.height / 2;
    self.existingAccountButton.clipsToBounds = YES;
}

- (void)roundButton:(UIButton *)buttonToRound {
    buttonToRound.layer.cornerRadius = buttonToRound.frame.size.width / 2;
    buttonToRound.clipsToBounds = YES;
}


@end
