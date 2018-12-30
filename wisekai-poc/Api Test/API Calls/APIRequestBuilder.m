//
//  APIRequestBuilder.m
//  wisekai-poc
//
//  Created by Ahmed on 29/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "APIRequestBuilder.h"

@implementation APIRequestBuilder

+ (NSMutableURLRequest *)getCreateTeacherRequest {
    
    //Set up your request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://wisekai.com:8085/api/v1/auth/"]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary * reqBody = @{
                               
                               @"username": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-username"],
                               @"password": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-password"],
                               @"party": @{
                                       
                                       @"dob": @"2018-12-28T19:01:41.996Z",
                                       @"email": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-email"],
                                       @"firstName": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-firstname"],
                                       @"lastName": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-lastname"],
                                       @"gender": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-gender"],
                                       @"interests": @[],
                                       @"mobile": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-phone"],
                                       @"partyType": @"T",
                                       @"qualifications": @[
                                               @{
                                                   @"fromDate": @"2018-12-28T19:01:41.996Z",
                                                   @"title": @"Some Education",
                                                   @"toDate": @"2018-12-28T19:01:41.996Z"
                                                   }
                                               ]
                                       }
                               };
    
    NSError * jsonError;
    NSData * postData = [NSJSONSerialization dataWithJSONObject:reqBody options:NSJSONWritingSortedKeys error:&jsonError];
    
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    
    return request;
    
}

+ (NSMutableURLRequest *)getLoginRequest {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://wisekai.com:8085/api/v1/authentication/"]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"GET"];
    
    return request;
    
}

+ (NSMutableURLRequest *)getPartyRequest {
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://wisekai.com:8085/api/v1/party/"]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"GET"];
    
    return request;
}


+ (NSMutableURLRequest *)getLessons {
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://wisekai.com:8085/v1/api/lesson/"]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"GET"];
    
    return request;
}

+ (NSMutableURLRequest *)createLesson {
    
    //Set up your request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://wisekai.com:8085/api/v1/lesson/"]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary * reqBody = @{
                               @"title": @"Test Lesson 1",
                               @"description": @"Verifying if the teacher can add a lesson",
                               @"objective": @"Objective less lesson",
                               @"active": @TRUE,
                               @"classSize": @20,
                               @"durationInMins": @80,
                               @"lat": @"25.204849",
                               @"lon": @"55.270782",
                               @"price": @120,
                               @"schedules": @[
                                       @{
                                           @"active": @TRUE,
                                           @"dayOfWeek": @5,
                                           @"minuteOfDay_startTime": @90,
                                           @"createdDate": @"2018-12-28T20:38:00.903Z",
                                           }
                                       ],
                               @"tags": @[ // At least Three Tags
                                       
                                       @{
                                           @"tag": @"Tag one"
                                           
                                           },
                                       @{
                                           @"tag": @"Entertainment"
                                           },
                                       @{
                                           @"tag": @"Tag Three"
                                           },
                                       ],
                               @"venue": @"Aashiyana House"
                               };
    
    NSError * jsonError;
    NSData * reqBodyData = [NSJSONSerialization dataWithJSONObject:reqBody options:NSJSONWritingSortedKeys error:&jsonError];
    
    [request setHTTPBody:reqBodyData];
    [request setHTTPMethod:@"PUT"];
    
    return request;
    
}

@end
