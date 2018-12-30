//
//  AddLessonViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 24/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "AddLessonViewController.h"
#import "UIColor+Wisekai.h"
#import <AVFoundation/AVFoundation.h>


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
    [self setPhotoLibraryPicker];
    [self setTextfields];
}

- (void)viewWillAppear:(BOOL)animated {
    [self addTapGesture];
}


#pragma mark - Helpers

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
    
    self.classSizeLabel.text = [NSString stringWithFormat:@"%0.0f", self.classSizeSlider.value];
    self.lessonDurationLabel.text = [NSString stringWithFormat:@"%0.0f", self.classDurationSlider.value];
    
}

- (void)addTapGesture {
    
    UITapGestureRecognizer * addImagePrimaryTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadImage)];
    UITapGestureRecognizer * addImageSecondaryTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadImage)];
    UITapGestureRecognizer * addImageTertiaryTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadImage)];
    UITapGestureRecognizer * addImageQuartenaryTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadImage)];
    
}


- (void)uploadImage {
    
    NSLog(@"Tap detected");
    
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
    [self setTextFieldBorder:self.lessonTagsTextfield];
    
    self.lessonNameTextfield.delegate = self;
    self.lessonDescriptionTextfield.delegate = self;
    self.lessonObjectiveTextfield.delegate = self;
    self.lessonTagsTextfield.delegate = self;
    
    
    self.lessonNameTextfield.returnKeyType = UIReturnKeyDone;
    self.lessonDescriptionTextfield.returnKeyType = UIReturnKeyDone;
    self.lessonObjectiveTextfield.returnKeyType = UIReturnKeyDone;
    self.lessonTagsTextfield.returnKeyType = UIReturnKeyDone;
    
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
    
    [self performSegueWithIdentifier:@"addlessondetails" sender:nil];
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

@end
