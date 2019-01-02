//
//  UIImageView+WiseKai.h
//  wisekai-poc
//
//  Created by Ahmed on 16/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (WiseKai)

+ (UIImageView *)getNavBarImageViewForIcon:(NSString *)imageName;

+ (UIImageView *)getTeacherToolbarImageViewForIcon:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
