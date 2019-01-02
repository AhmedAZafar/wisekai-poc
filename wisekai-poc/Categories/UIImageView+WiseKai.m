//
//  UIImageView+WiseKai.m
//  wisekai-poc
//
//  Created by Ahmed on 16/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "UIImageView+WiseKai.h"

@implementation UIImageView (WiseKai)

+ (UIImageView *)getNavBarImageViewForIcon:(NSString *)imageName {
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    
    imgView.image = [UIImage imageNamed:imageName];
    
    return imgView;
}


+ (UIImageView *)getTeacherToolbarImageViewForIcon:(NSString *)imageName {
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    
    imgView.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    return imgView;
}

@end
