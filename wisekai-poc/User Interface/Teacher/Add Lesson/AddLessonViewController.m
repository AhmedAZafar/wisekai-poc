//
//  AddLessonViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 24/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "AddLessonViewController.h"
#import "UIColor+Wisekai.h"

#import <Toast/Toast.h>
#import <DownPicker/DownPicker.h>


@interface AddLessonViewController ()

{
    UIImagePickerController * imagePicker;
    UIImagePickerController * cameraPicker;
    
}

@end

@implementation AddLessonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLayout];
    [self setNavbar];
    [self setPhotoLibraryPicker];
    [self setTextfields];
}


#pragma mark - Helpers

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
    
    self.classSizeLabel.text = [NSString stringWithFormat:@"%0.0f", self.classSizeSlider.value];
    self.lessonDurationLabel.text = [NSString stringWithFormat:@"%0.0f", self.classDurationSlider.value];
    
    self.lessonNameTextfield.backgroundColor = [UIColor wiseKaiCreamColor];
    self.lessonDescriptionTextfield.backgroundColor = [UIColor wiseKaiCreamColor];
    self.lessonObjectiveTextfield.backgroundColor = [UIColor wiseKaiCreamColor];
    
    self.addLessonScrollView.backgroundColor = [UIColor wiseKaiCreamColor];
    self.addLessonContentView.backgroundColor = [UIColor wiseKaiCreamColor];
    
    [self.nextButton setBackgroundColor:[UIColor wiseKaiRedColor]];
    [self.nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.nextButton.layer.cornerRadius = self.nextButton.frame.size.height / 2;
    self.nextButton.clipsToBounds = YES;
    
}

- (void)setNavbar {
    
    self.navigationItem.title = @"Create New Lesson";
    
    //Set Font
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:17.0],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = size;
    
    //Set Color
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor wiseKaiRedColor],NSForegroundColorAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(popViewControllerAnimated:)];
    
    backButton.tintColor = [UIColor wiseKaiDarkGrayColor];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
}


- (void)uploadImage {
    
    NSLog(@"Tap detected");
    /*
    if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusAuthorized) {
        NSLog(@"Access already granted");
        [self presentViewController:imagePicker animated:YES completion:nil];
        //[self presentModalViewController:imagePicker animated:YES];
    } else {
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                NSLog(@"Access Granted");
                [self presentViewController:self->imagePicker animated:YES completion:nil];
                //[self presentModalViewController:imagePicker animated:YES];
            }
        }];
        
    }
    
    //Alert Sheet
    /*
    UIAlertController * imageAlert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * uploadImageAction = [UIAlertAction actionWithTitle:@"Choose from Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setPhotoLibraryPicker];
    }];
    
    [imageAlert addAction:uploadImageAction];*/
    
    //Choice of action
    
    // If choose photo - [self presentModalViewController:imagePickerPhotoLibrary animated:YES];
}

- (void)setPhotoLibraryPicker {
    
    imagePicker =  [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    
    //cameraPicker = [[UIImagePickerController alloc] init];
    //cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //cameraPicker.delegate = self;
    
}

- (void)setTextfields {
    
    [self setTextFieldBorder:self.lessonNameTextfield];
    [self setTextFieldBorder:self.lessonDescriptionTextfield];
    [self setTextFieldBorder:self.lessonObjectiveTextfield];
    
    self.lessonNameTextfield.delegate = self;
    self.lessonDescriptionTextfield.delegate = self;
    self.lessonObjectiveTextfield.delegate = self;
    
    
    self.lessonNameTextfield.returnKeyType = UIReturnKeyDone;
    self.lessonDescriptionTextfield.returnKeyType = UIReturnKeyDone;
    self.lessonObjectiveTextfield.returnKeyType = UIReturnKeyDone;
    
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

#pragma mark - IBActions

- (IBAction)didChangeNumberOfStudents:(id)sender {
    UISlider * currentSlider = (UISlider *)sender;
    self.classSizeLabel.text = [NSString stringWithFormat:@"%0.0f", currentSlider.value];
}

- (IBAction)didChangeLessonDuration:(id)sender {
    UISlider * currentSlider = (UISlider *)sender;
    self.lessonDurationLabel.text = [NSString stringWithFormat:@"%0.0f", currentSlider.value];
}

- (IBAction)didChangeLessonPrice:(id)sender {
    UISlider * currentSlider = (UISlider *)sender;
    self.priceLabel.text = [NSString stringWithFormat:@"AED %0.0f", currentSlider.value];
}

- (IBAction)didSelectNextButton:(id)sender {
    
    if ([self validateTextfields]) {
        
        [self addLessonValuesToPersistenceStore];
        
        [self performSegueWithIdentifier:@"addlessondetails" sender:nil];
    } else {
        [self.view makeToast:@"Please fill out fields" duration:1.0 position:CSToastPositionCenter];
    }
}


#pragma mark - ImagePicker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    NSLog(@"My Picker has the following stuff %@", picker);
    
    NSLog(@"Info From Media : %@", info);
    NSData * imageData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:UIImagePickerControllerImageURL]];
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Textfield Validator

- (BOOL)validateTextfields {
    
    if ((self.lessonNameTextfield.text.length > 0) &&
        (self.lessonDescriptionTextfield.text.length > 0) &&
        (self.lessonObjectiveTextfield.text.length > 0) &&
        (self.priceSlider.value > 0.0)){
        
        return true;
        
    } else {
        
        return false;
    }
    
}

#pragma mark - Persistence Store

- (void)addLessonValuesToPersistenceStore {
    
    NSString * lessonDurationString = [NSString stringWithFormat:@"%0.0f", self.classDurationSlider.value];
    NSString * lessonStudents = [NSString stringWithFormat:@"%0.0f", self.classSizeSlider.value];
    NSString * lessonPrice = [NSString stringWithFormat:@"%0.0f", self.priceSlider.value];
    
    NSDictionary * newLessonDict = @{
                                     @"lesson-name":self.lessonNameTextfield.text,
                                     @"lesson-description":self.lessonDescriptionTextfield.text,
                                     @"lesson-objective":self.lessonObjectiveTextfield.text,
                                     @"lesson-duration":lessonDurationString,
                                     @"lesson-students":lessonStudents,
                                     @"lesson-price":lessonPrice
                                     };
    
    [[NSUserDefaults standardUserDefaults] setObject:newLessonDict forKey:@"new-lesson"];
    
}

@end
