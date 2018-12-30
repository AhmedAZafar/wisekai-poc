//
//  SignUpQualificationViewController.h
//  wisekai-poc
//
//  Created by Ahmed on 29/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignUpQualificationViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mandatoryQualificationTextfield;
@property (weak, nonatomic) IBOutlet UITextField *secondaryQualificationTextfield;
@property (weak, nonatomic) IBOutlet UITextField *tertiaryQualificationTextfield;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end

NS_ASSUME_NONNULL_END
