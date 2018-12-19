//
//  UserViewController.h
//  wisekai-poc
//
//  Created by Ahmed Ali Zafar on 19/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userEmail;
@property (weak, nonatomic) IBOutlet UILabel *userRegion;
@property (weak, nonatomic) IBOutlet UITextView *userDescription;

@end

NS_ASSUME_NONNULL_END
