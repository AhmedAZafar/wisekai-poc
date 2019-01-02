//
//  TeacherProfileViewController.h
//  wisekai-poc
//
//  Created by Ahmed on 02/01/2019.
//  Copyright © 2019 Ahmed Ali Zafar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeacherProfileViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIToolbar *teacherToolbar;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tapToEditLabel;
@property (weak, nonatomic) IBOutlet UITextField *genderTextfield;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UITextField *areaTextfield;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UITextView *userDescriptionTextview;
@property (weak, nonatomic) IBOutlet UILabel *userDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView * imageActivityIndicator;

@end

NS_ASSUME_NONNULL_END
