//
//  APICalls.h
//  wisekai-poc
//
//  Created by Ahmed on 28/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APICalls : NSObject

+ (void)createStudent;
+ (void)createTeacher:(void (^)(NSData * responseData))completion;
+ (void)loginUser:(void (^)(NSData * responseData))completion;
+ (void)getParty:(void (^)(NSData * responseData))completion;
+ (void)getLessons:(void (^)(NSData * responseData))completion;
+ (void)createLesson:(void (^)(NSData * responseData))completion;
+ (void)updateStudent;
+ (void)updateTeacher;

+ (void)getSlotsForLesson;
+ (void)createBookingForLesson;
+ (void)searchLessonsStudent;
+ (void)getBookingsStudent;

@end

NS_ASSUME_NONNULL_END
