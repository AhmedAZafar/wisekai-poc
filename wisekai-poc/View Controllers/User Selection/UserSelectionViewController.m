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

- (IBAction)didSelectTeacherButotn:(id)sender {
    [self segueToNext];
}
- (IBAction)didSelectStudentButton:(id)sender {
    [self segueToNext];
}

#pragma mark - Helpers

- (void)setLayout {
    self.view.backgroundColor = [UIColor wiseKaiDarkPurpleColor];
    
    self.teacherButton.backgroundColor = [UIColor wiseKaiPinkColor];
    [self roundButton:self.teacherButton];
    
    self.studentButton.backgroundColor = [UIColor wiseKaiGreenColor];
    [self roundButton:self.studentButton];
}

- (void)roundButton:(UIButton *)buttonToRound {
    buttonToRound.layer.cornerRadius = buttonToRound.frame.size.width / 2;
    buttonToRound.clipsToBounds = YES;
}

- (void)segueToNext {
    
    UIStoryboard * loginBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];

    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:loginBoard.instantiateInitialViewController];
    
    UIImageView * backButtonImageView = [UIImageView getNavBarImageViewForIcon:@"toolbar-like"];
    
    UIView * backButtonItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    
    [backButtonItemView addSubview:backButtonImageView];
    
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonItemView];
    
    navController.navigationItem.backBarButtonItem = backButtonItem;
    
    [self presentViewController:navController animated:YES completion:nil];
}


@end
