//
//  LessonCell.h
//  wisekai-poc
//
//  Created by Ahmed on 18/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LessonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *lessonImageView;
@property (weak, nonatomic) IBOutlet UILabel *lessonTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessonDescriptionLabel;

@end

NS_ASSUME_NONNULL_END
