//
//  TeacherLessonCell.h
//  wisekai-poc
//
//  Created by Ahmed on 29/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeacherLessonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lessonPrice;
@property (weak, nonatomic) IBOutlet UILabel *lessonName;
@property (weak, nonatomic) IBOutlet UILabel *lessonDescription;
@property (weak, nonatomic) IBOutlet UIImageView *lessonImage;

@end

NS_ASSUME_NONNULL_END
