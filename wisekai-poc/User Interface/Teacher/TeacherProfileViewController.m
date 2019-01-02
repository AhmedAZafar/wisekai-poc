//
//  TeacherProfileViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 02/01/2019.
//  Copyright © 2019 Ahmed Ali Zafar. All rights reserved.
//

#import "TeacherProfileViewController.h"
#import "UIColor+Wisekai.h"
#import "UIView+Wisekai.h"
#import "UIImageView+WiseKai.h"

@interface TeacherProfileViewController () {
    UITapGestureRecognizer * imageTap;
    UITapGestureRecognizer * labelTap;
}

@end

@implementation TeacherProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayout];
    [self setNavBar];
    [self setToolbar];
    [self setTextfields];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setTapGestures];
}

- (void)viewDidAppear:(BOOL)animated {
    
    self.imageActivityIndicator.layer.zPosition = 1;
    [self.imageActivityIndicator startAnimating];
    
    NSData * persistenceData = [[NSUserDefaults standardUserDefaults] valueForKey:@"user-image"];
    
    if ([persistenceData length] > 0) {
        self.userImage.image = [UIImage imageWithData:persistenceData];
    } else {
        self.userImage.image = [UIImage imageNamed:@"user"];
    }
    
    [self.imageActivityIndicator stopAnimating];
    self.imageActivityIndicator.layer.zPosition = 0;
    self.imageActivityIndicator.alpha = 0.0;
    
}

#pragma mark - Helpers

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
    
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
    self.userImage.clipsToBounds = YES;
    
    self.userDescriptionTextview.backgroundColor = [UIColor clearColor];
    
    self.imageActivityIndicator.alpha = 0.0;
    
    //self.activityIndicatorView.alpha = 0.0;
}

- (void)setNavBar {
    
    self.navigationItem.title = @"Profile";
    
    //Set Font
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:17.0],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = size;
    
    //Set Color
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor wiseKaiRedColor],NSForegroundColorAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    //Set Back Button
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(popViewControllerAnimated:)];
    
    backButton.tintColor = [UIColor wiseKaiDarkGrayColor];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    //Set Edit
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(didEnterEditMode)];
    
    rightButton.tintColor = [UIColor wiseKaiDarkGrayColor];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
}

- (void)setToolbar {
    
    /*
     //Set up Search Icon
     UITapGestureRecognizer * searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectSearchIcon)];
     
     UIView * searchView = [UIView getNavBarIconView];
     
     [searchView addGestureRecognizer:searchTap];
     
     [searchView addSubview:[UIImageView getNavBarImageViewForIcon:@"toolbar-search"]];
     
     UIBarButtonItem * searchBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchView];
     
     
     //Set up Like Icon
     UITapGestureRecognizer * likeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectLikeIcon)];
     
     UIView * likeView = [UIView getNavBarIconView];
     
     [likeView addGestureRecognizer:likeTap];
     
     [likeView addSubview:[UIImageView getNavBarImageViewForIcon:@"toolbar-like"]];
     
     UIBarButtonItem * likeBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:likeView];
     
     //Set up Calendar Icon
     UITapGestureRecognizer * calendarTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectCalendarIcon)];
     
     UIView * calendarView = [UIView getNavBarIconView];
     
     [calendarView addGestureRecognizer:calendarTap];
     
     [calendarView addSubview:[UIImageView getNavBarImageViewForIcon:@"toolbar-calendar"]];
     
     UIBarButtonItem * calendarBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:calendarView];
     
     
    //Set up Notification Icon
    UITapGestureRecognizer * notificationTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectNotificationIcon)];
    
    UIView * notificationView = [UIView getNavBarIconView];
    
    [notificationView addGestureRecognizer:notificationTap];
    
    UIImageView * currentTab = [UIImageView getTeacherToolbarImageViewForIcon:@"toolbar-alert"];
    
    currentTab.tintColor = [UIColor wiseKaiRedColor];
    
    [notificationView addSubview:currentTab];
    
    UIBarButtonItem * notificationBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationView];
    */
    
    
     //Set up User Icon
     UITapGestureRecognizer * userTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectUserIcon)];
     
     UIView * userView = [UIView getNavBarIconView];
     
     [userView addGestureRecognizer:userTap];
    
    UIImageView * currentTab = [UIImageView getTeacherToolbarImageViewForIcon:@"toolbar-user"];
    
    currentTab.tintColor = [UIColor wiseKaiRedColor];
     
     [userView addSubview:currentTab];
     
     UIBarButtonItem * userBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:userView];
     
     UIBarButtonItem * flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
     
     //self.bottomToolbar.items = @[searchBarButtonItem, flexibleSpace,likeBarButtonItem,flexibleSpace, calendarBarButtonItem,flexibleSpace, notificationBarButtonItem,flexibleSpace, userBarButtonItem];

    
    self.teacherToolbar.items = @[flexibleSpace, userBarButtonItem, flexibleSpace];
    
}

- (void)setTextfields {
    
    self.usernameTextfield.delegate = self;
    self.genderTextfield.delegate = self;
    self.areaTextfield.delegate = self;
    
    [self setTextFieldBorder:self.usernameTextfield];
    [self setTextFieldBorder:self.genderTextfield];
    [self setTextFieldBorder:self.areaTextfield];
    
    NSString * firstName = [[NSUserDefaults standardUserDefaults] valueForKey:@"user-firstname"];
    NSString * lastName = [[NSUserDefaults standardUserDefaults] valueForKey:@"user-lastname"];
    
    NSString * nameString;
    
    if (firstName.length > 0 && lastName.length > 0) {
        nameString = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    }
    
    if (firstName.length > 0 && lastName.length <= 0) {
        nameString = [NSString stringWithFormat:@"%@", firstName];
    }
    
    if (lastName.length > 0 && firstName.length <=0) {
        nameString = [NSString stringWithFormat:@"%@", lastName];
    }
    
    self.usernameTextfield.text = nameString;
    
    NSString * gender = [[NSUserDefaults standardUserDefaults] valueForKey:@"user-gender"];
    
    if (gender.length > 0) {
        self.genderTextfield.text = gender;
    } else {
        self.genderTextfield.placeholder = @"Add you gender in edit mode";
    }
    
    NSString * area = [[NSUserDefaults standardUserDefaults] valueForKey:@"user-area"];
    
    if (area.length > 0) {
        self.areaTextfield.text = area;
    } else {
        self.areaTextfield.placeholder = @"Add your area in edit mode";
    }
    
    [self disableEditing];
    
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

- (void)setTapGestures {

    

}

- (void)addTapGestures {
    
    self.userImage.userInteractionEnabled = YES;
    self.tapToEditLabel.userInteractionEnabled = YES;
    
    imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectChangeImage)];
    
    labelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectChangeImage)];
    
    [self.userImage addGestureRecognizer:imageTap];
    [self.tapToEditLabel addGestureRecognizer:labelTap];
    
}

- (void)removeTapGestures {
    
    self.userImage.userInteractionEnabled = NO;
    self.tapToEditLabel.userInteractionEnabled = NO;
    
    [self.userImage removeGestureRecognizer:imageTap];
    [self.tapToEditLabel removeGestureRecognizer:labelTap];
}

- (void)disableEditing {
    
    self.usernameTextfield.userInteractionEnabled = NO;
    self.genderTextfield.userInteractionEnabled = NO;
    self.areaTextfield.userInteractionEnabled = NO;
    self.userDescriptionTextview.userInteractionEnabled = NO;
    
    self.tapToEditLabel.alpha = 0.0;
    
}

- (void)enableEditing {
    
    self.usernameTextfield.userInteractionEnabled = YES;
    self.genderTextfield.userInteractionEnabled = YES;
    self.areaTextfield.userInteractionEnabled = YES;
    self.userDescriptionTextview.userInteractionEnabled = YES;
    
    self.tapToEditLabel.alpha = 1.0;
    
}

#pragma mark - Navigation

- (void)segueToNotifications {
    [self performSegueWithIdentifier:@"showalerts" sender:nil];
}

- (void)segueToProfile {
    
}

#pragma mark - IBACtions

- (void)didEnterEditMode {
    
    UIBarButtonItem * barButton = self.navigationItem.rightBarButtonItem;
    
    if ([barButton.title isEqualToString:@"Edit"]) {
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
        [self enableEditing];
        [self addTapGestures];
    } else {
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
        [self disableEditing];
        [self removeTapGestures];
        [self updatePersistenceStore];
    }
}

- (void)updatePersistenceStore {
    
    NSArray * splittedName = [self.usernameTextfield.text componentsSeparatedByString:@" "];
    NSString * firstName = splittedName.firstObject;
    NSString * lastName = splittedName.lastObject;
    
    [[NSUserDefaults standardUserDefaults] setObject:firstName forKey:@"user-firstname"];
    [[NSUserDefaults standardUserDefaults] setObject:lastName forKey:@"user-lastname"];
    
    [[NSUserDefaults standardUserDefaults]  setObject:self.genderTextfield.text forKey:@"user-gender"];
    [[NSUserDefaults standardUserDefaults] setObject:self.userDescriptionTextview.text forKey:@"user-description"];
    
}

- (void)didSelectUserIcon {
    
}

#pragma mark - UIImage Delegate

- (void)didSelectChangeImage {
    
    NSLog(@"didSelect Change Image");
    
    UIAlertController * picSelectionController = [UIAlertController alertControllerWithTitle:@"Set your picture" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * takePhotoAction = [UIAlertAction actionWithTitle:@"Take a Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Take a photo sequence
        [self presentCamera];
    }];
    
    UIAlertAction * chooseFromLibraryAction = [UIAlertAction actionWithTitle:@"Choose from Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Choose from Library sequence
        [self presentPhotoRoll];
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    /*UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Take a Photo",
                            @"Choose from Photo Library",
                            nil];
    
    [sheet showInView:self.view];*/
    
    [picSelectionController addAction:takePhotoAction];
    [picSelectionController addAction:chooseFromLibraryAction];
    [picSelectionController addAction:cancelAction];
    
    [self presentViewController:picSelectionController animated:YES completion:nil];
    
}

- (void)presentCamera {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    picker.showsCameraControls = YES;
    
    [picker.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [picker.navigationBar setTitleTextAttributes:nil];
    [picker.navigationBar setBarTintColor:nil];
    
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)presentPhotoRoll {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [picker.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [picker.navigationBar setTitleTextAttributes:nil];
    [picker.navigationBar setBarTintColor:nil];
    
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!img)
        img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.userImage.image = img;
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(img) forKey:@"user-image"];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //CB3UserPhotoController *vc = [[CB3UserPhotoController alloc] initWithNibName:@"CB3UserPhotoController" bundle:nil];
    
    //vc.image = img;
    //vc.delegate = self;
    
    //[picker pushViewController:vc animated:YES];
}



@end
