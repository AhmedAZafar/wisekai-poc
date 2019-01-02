//
//  TeacherViewController.h
//  wisekai-poc
//
//  Created by Ahmed on 24/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeacherViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *teacherTableView;
@property (weak, nonatomic) IBOutlet UIToolbar *teacherToolbar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (strong, nonatomic) NSArray * lessonListArray;

@end

NS_ASSUME_NONNULL_END
