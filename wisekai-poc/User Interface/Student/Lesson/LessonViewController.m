//
//  LessonViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 19/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "LessonViewController.h"
#import "UIColor+Wisekai.h"

@interface LessonViewController ()

@end

@implementation LessonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayout];
    [self setNavBar];
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
    
    self.navigationController.navigationBar.layer.zPosition = -1;
    
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
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
