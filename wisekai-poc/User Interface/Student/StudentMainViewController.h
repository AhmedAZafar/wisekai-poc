//
//  StudentMainViewController.h
//  wisekai-poc
//
//  Created by Ahmed on 16/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StudentMainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *lessonListTable;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomToolbar;

@end

NS_ASSUME_NONNULL_END
