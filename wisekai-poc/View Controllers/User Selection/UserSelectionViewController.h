//
//  UserSelectionViewController.h
//  wisekai-poc
//
//  Created by Ahmed on 11/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserSelectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *teacherButton;
@property (weak, nonatomic) IBOutlet UIButton *studentButton;
@property (weak, nonatomic) IBOutlet UIButton *existingAccountButton;

@end

NS_ASSUME_NONNULL_END
