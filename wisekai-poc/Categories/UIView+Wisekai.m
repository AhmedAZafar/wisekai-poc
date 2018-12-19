//
//  UIView+Wisekai.m
//  wisekai-poc
//
//  Created by Ahmed on 16/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "UIView+Wisekai.h"

@implementation UIView (Wisekai)

+ (UIView *)getNavBarIconView {
    UIView * navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    
    navBarView.layer.cornerRadius = navBarView.frame.size.width / 2;
    navBarView.clipsToBounds = YES;
    navBarView.userInteractionEnabled = YES;
    
    return navBarView;
}

@end
