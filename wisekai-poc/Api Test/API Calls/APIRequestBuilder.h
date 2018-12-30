//
//  APIRequestBuilder.h
//  wisekai-poc
//
//  Created by Ahmed on 29/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIRequestBuilder : NSObject

+ (NSMutableURLRequest *)getCreateTeacherRequest;

+ (NSMutableURLRequest *)getLoginRequest;

+ (NSMutableURLRequest *)getPartyRequest;

+ (NSMutableURLRequest *)getLessons;

+ (NSMutableURLRequest *)createLesson;


@end

NS_ASSUME_NONNULL_END
