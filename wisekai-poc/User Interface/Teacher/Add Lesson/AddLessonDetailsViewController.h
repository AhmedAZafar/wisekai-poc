//
//  AddLessonDetailsViewController.h
//  wisekai-poc
//
//  Created by Ahmed on 30/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XLForm/XLForm.h>
//#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddLessonDetailsViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *lessonDayTextfield;
@property (weak, nonatomic) IBOutlet UITextField *startTimeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *lessonTagOeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *lessonTagTwoTextfield;
@property (weak, nonatomic) IBOutlet UITextField *lessonTagThreeTextfield;
@property (weak, nonatomic) IBOutlet UILabel *lessonLocationLabel;
@property (weak, nonatomic) IBOutlet UIButton *createLessonButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

NS_ASSUME_NONNULL_END
