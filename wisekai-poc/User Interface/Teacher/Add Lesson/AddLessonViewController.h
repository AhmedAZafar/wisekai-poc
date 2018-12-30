//
//  AddLessonViewController.h
//  wisekai-poc
//
//  Created by Ahmed on 24/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddLessonViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField * lessonNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField * lessonDescriptionTextfield;
@property (weak, nonatomic) IBOutlet UITextField * lessonObjectiveTextfield;
@property (weak, nonatomic) IBOutlet UITextField *lessonTagsTextfield;
@property (weak, nonatomic) IBOutlet UISlider * classSizeSlider;
@property (weak, nonatomic) IBOutlet UISlider * classDurationSlider;
@property (weak, nonatomic) IBOutlet UILabel *classSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessonDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UISlider *priceSlider;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

NS_ASSUME_NONNULL_END
