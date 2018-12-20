//
//  LessonViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 19/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "LessonViewController.h"
#import "UIColor+Wisekai.h"

#import <Toast/Toast.h>

@interface LessonViewController ()

@end

@implementation LessonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayout];
    [self setNavBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setNavBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self unsetNavBar];
    self.bookLessonButton.userInteractionEnabled = YES;
                                                               
}

#pragma mark - Helpers

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
    
    self.mainBannerImageView.backgroundColor = [UIColor wiseKaiBlackColor];
    self.mainBannerImageView.tintColor = [UIColor whiteColor];
    
    self.lessonTitleLabel.text = self.lessonName;
    self.lessonTitleLabel.textColor = [UIColor whiteColor];
    
    self.teacherImageView.image = [[UIImage imageNamed:self.lessonImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.teacherImageView.tintColor = [UIColor whiteColor];
    
    self.teacherNameLabel.text = @"by Famous Instructor";
    self.teacherNameLabel.textColor = [UIColor whiteColor];
    
    self.mainBannerImageView.layer.zPosition = 0;
    self.teacherImageView.layer.zPosition = 1;
    self.teacherNameLabel.layer.zPosition = 1;
    
    self.studentsIconImageView.image = [[UIImage imageNamed:@"lesson-students"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.studentsIconImageView.tintColor = [UIColor wiseKaiBlueColor];
    
    self.lessonStudentsLabel.text = @"Class of 4";
    
    self.ageIconImageView.image = [[UIImage imageNamed:@"lesson-age"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.ageIconImageView.tintColor = [UIColor wiseKaiBlueColor];
    
    self.lessonAgeLabel.text = @"All Ages";
    
    self.calendarIconImageView.image = [[UIImage imageNamed:@"toolbar-calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.calendarIconImageView.tintColor = [UIColor wiseKaiBlueColor];
    
    self.lessonCalendarLabel.text = @"Dec 27 2018";
    
    self.timeIconImageView.image = [[UIImage imageNamed:@"lesson-time"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.timeIconImageView.tintColor = [UIColor wiseKaiBlueColor];
    
    self.lessonTimeLabel.text = @"12:00 - 14:00";
    
    self.transparentBackButton.image = [[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.transparentBackButton.tintColor = [UIColor whiteColor];
    
}

- (void)setNavBar {
    self.navigationController.navigationBar.layer.zPosition = -1;
}

- (void)unsetNavBar {
    self.navigationController.navigationBar.layer.zPosition = 1;
}

#pragma mark - IBActions

- (IBAction)didSelectBookLessonButton:(id)sender {
    
    self.bookLessonButton.userInteractionEnabled = NO;
    self.bookLessonButton.alpha = 0.0;
    
    [UIView animateWithDuration:2.0 animations:^{
            [self.view makeToast:@"Lesson Booked" duration:2.0 position:CSToastPositionCenter];
    } completion:^(BOOL finished) {
        if (finished) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
