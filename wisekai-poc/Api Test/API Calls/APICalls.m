//
//  APICalls.m
//  wisekai-poc
//
//  Created by Ahmed on 28/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "APICalls.h"
#import "APIHelper.h"
#import "APIRequestBuilder.h"

@implementation APICalls

+ (void)createStudent {
}

+ (void)createTeacher:(void (^)(NSData * responseData))completion {
    
    //Set up your request
    NSMutableURLRequest * request = [APIRequestBuilder getCreateTeacherRequest];
    
    // Set your user login credentials
    [request setValue:[APIHelper getBasicAuthStringFromUserDefaults] forHTTPHeaderField:@"Authorization"];
    
    NSURLSession * session = [APIHelper getWisekaiDefaultSession];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            if ([data length] > 0 && error == nil) {

                completion(data);
            }
        }
    }] resume];
}

+ (void)loginUser:(void (^)(NSData * _Nonnull))completion {

    //Set up your request
    NSMutableURLRequest *request = [APIRequestBuilder getLoginRequest];
    
    [request setValue:[APIHelper getBasicAuthStringFromUserDefaults] forHTTPHeaderField:@"Authorization"];
    
    NSURLSession * session = [APIHelper getWisekaiDefaultSession];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            if ([data length] > 0 && error == nil) {
                
                completion(data);
            }
        }
    }] resume];
    
}

+ (void)getParty:(void (^)(NSData * _Nonnull))completion {
    
    NSMutableURLRequest * request = [APIRequestBuilder getPartyRequest];
    
    [request setValue:[APIHelper getBasicAuthStringFromUserDefaults] forHTTPHeaderField:@"Authorization"];
    
    NSURLSession * session = [APIHelper getWisekaiDefaultSession];
    
    [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            if ([data length] > 0 && error == nil) {
                completion(data);
            }
        }
    }];
    
}

+ (void)getLessons:(void (^)(NSData * _Nonnull))completion {
    
    NSMutableURLRequest * request = [APIRequestBuilder getLessons];
    
    [request setValue:[APIHelper getBasicAuthStringFromUserDefaults] forHTTPHeaderField:@"Authorization"];
    
    NSURLSession * session = [APIHelper getWisekaiDefaultSession];
    
    [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            if ([data length] > 0 && error == nil) {
                completion(data);
            }
        }
    }];
    
}

+ (void)createLesson:(void (^)(NSData * _Nonnull))completion {
    
}

+ (void)updateStudent {
}

+ (void)updateTeacher {
}

+ (void)getLessonHistoryStudent {
}

+ (void)getLessonHistoryTeacher:(void (^)(void))callbackBlock {
}

+ (void)getSlotsForLesson {
}


+ (void)createBookingForLesson {
}


+ (void)searchLessonsStudent {
}


+ (void)getBookingsStudent {
}

@end
