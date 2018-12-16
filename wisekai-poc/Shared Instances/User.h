//
//  User.h
//  wisekai-poc
//
//  Created by Ahmed on 12/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

//@property (strong, nonatomic) BOOL * isFirstApplicationRun;
@property (strong, nonatomic) NSString * userType;

+ (User *) getCurrentUser;

@end

NS_ASSUME_NONNULL_END
