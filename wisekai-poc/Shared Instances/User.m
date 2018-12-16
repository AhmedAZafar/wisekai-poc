//
//  User.m
//  wisekai-poc
//
//  Created by Ahmed on 12/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *)getCurrentUser {
    
    static User * user = nil;
    
    if(!user) {
        user = [[User allocWithZone:nil] init];
    }
    
    return user;
    
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    return [self getCurrentUser];
}

@end
