//
//  LessonViewController.h
//  wisekai-poc
//
//  Created by Ahmed on 19/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LessonViewController : UIViewController

@property (strong, nonatomic) NSString * lessonName;
@property (strong, nonatomic) NSString * lessonDescription;
@property (strong, nonatomic) NSString * lessonImageName;
@property (weak, nonatomic) IBOutlet UIView *topBannerView;
@property (weak, nonatomic) IBOutlet UIImageView *mainBannerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *teacherImageView;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *antImageView;
@property (weak, nonatomic) IBOutlet UILabel *lessonTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *studentsIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *calendarIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ageIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *timeIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *lessonTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessonAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessonCalendarLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessonStudentsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *transparentBackButton;
@property (weak, nonatomic) IBOutlet UIButton *bookLessonButton;

@end

NS_ASSUME_NONNULL_END
