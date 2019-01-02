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

+ (void)createStudent:(void (^)(NSData * responseData))completion {
    
    //Set up your request
    NSMutableURLRequest * request = [APIRequestBuilder getCreateStudentRequest];
    
    NSLog(@"HTTP Headers: %@",[APIHelper getBasicAuthStringFromUserDefaults]);
    
    // Set your user login credentials
    [request setValue:[APIHelper getWisekaiAuthString] forHTTPHeaderField:@"Authorization"];
    
    NSURLSession * session = [APIHelper getWisekaiDefaultSession];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            if ([data length] > 0 && error == nil) {
                
                completion(data);
            }
        }
    }] resume];
}

+ (void)createTeacher:(void (^)(NSData * responseData))completion {
    
    //Set up your request
    NSMutableURLRequest * request = [APIRequestBuilder getCreateTeacherRequest];
    
    // Set your user login credentials
    [request setValue:[APIHelper getWisekaiAuthString] forHTTPHeaderField:@"Authorization"];
    
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
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            if ([data length] > 0 && error == nil) {
                completion(data);
            }
        }
    }] resume];
    
}

+ (void)getLessons:(void (^)(NSData * _Nonnull))completion {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://wisekai.com:8085/api/v1/lesson/"]];
    
    NSString * token = [[NSUserDefaults standardUserDefaults] valueForKey:@"bearer-token"];
    
    // Set your user login credentials
    [request setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if ([data length] > 0) {
            
            completion(data);
            
            /*NSLog(@"Got something for lesson list of teachers");
            
            NSError * responseReadError;
            NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&responseReadError];
            
            NSLog(@"Response dict for lessons for teacher %@", responseDict);*/
        }
    }];
    /*
    NSMutableURLRequest * request = [APIRequestBuilder getLessons];
    
    [request setValue:[APIHelper getBearerTokenFromPersistenceStore] forHTTPHeaderField:@"Authorization"];
    
    //NSURLSession * session = [APIHelper getWisekaiDefaultSession];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if ([data length] > 0) {
            
            NSLog(@"Got something for lesson list of teachers");
            
            NSError * responseReadError;
            NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&responseReadError];
            
            NSLog(@"Response dict for lessons for teacher %@", responseDict);
        }
    }];
    
   /*
    [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if ([response isKindOfClass:[NSURLResponse class]]) {
            if ([data length] > 0 && error == nil) {
                completion(data);
            }
        }
    }];*/
    
}

+ (void)createLesson:(void (^)(NSData * _Nonnull))completion {
    
    NSMutableURLRequest * request = [APIRequestBuilder createLesson];
    
    [request setValue:[APIHelper getBearerTokenFromPersistenceStore] forHTTPHeaderField:@"Authorization"];
    
    NSURLSession * session = [APIHelper getWisekaiDefaultSession];
    /*
    [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            NSLog(@"Response Found For Create Lesson");
            
            if ([data length] > 0 && error == nil) {
                
                NSLog(@"Response contains Data for Create Lesson");
                
                completion(data);
            }
        }
    }];*/
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if ([data length] > 0) {
            
            completion(data);
            //NSError * responseReadError;
            //NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&responseReadError];
            
            //NSLog(@"Lesson Add : %@", responseDict);
            
            
        }
    }];
    
}

+ (void)getNotifications:(void (^)(NSData * _Nonnull))completion {
    NSMutableURLRequest * request = [APIRequestBuilder getNotifications];
    
    NSString * bearer  = [APIHelper getBearerTokenFromPersistenceStore];
    
    NSLog(@"Bearer TOken: %@", bearer);
    
    if (bearer.length > 0) {
        
        [request setValue:[APIHelper getBearerTokenFromPersistenceStore] forHTTPHeaderField:@"Authorization"];
        
        NSURLSession * session = [APIHelper getWisekaiDefaultSession];
        
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if ([response isKindOfClass:[NSURLResponse class]]) {
                if ([data length] > 0) {
                    completion(data);
                }
            }
        }] resume];
        
    }
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
