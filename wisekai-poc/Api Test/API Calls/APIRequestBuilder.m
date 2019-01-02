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
    
    NSString * dob = [[NSUserDefaults standardUserDefaults] valueForKey:@"user-dob"];
    
    dob = [dob stringByReplacingOccurrencesOfString:@" " withString:@"T"];
    
    dob = [dob stringByAppendingString:@".000Z"];
    
    NSDictionary * reqBody = @{
                               
                               @"username": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-username"],
                               @"password": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-password"],
                               @"party": @{
                                       
                                       @"dob": dob,
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

+ (NSMutableURLRequest *)getCreateStudentRequest {
    
    //Set up your request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://wisekai.com:8085/api/v1/auth/"]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary * interests = [[NSUserDefaults standardUserDefaults] valueForKey:@"user-interests"];
    
    NSString * dob = [[NSUserDefaults standardUserDefaults] valueForKey:@"user-dob"];
    
    dob = [dob stringByReplacingOccurrencesOfString:@" " withString:@"T"];
    
    dob = [dob stringByAppendingString:@".000Z"];
    
    NSDictionary * reqBody = @{
                               
                               @"username": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-username"],
                               @"password": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-password"],
                               @"party": @{
                                       
                                       @"dob": dob,
                                       @"email": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-email"],
                                       @"firstName": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-firstname"],
                                       @"lastName": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-lastname"],
                                       @"gender": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-gender"],
                                       @"interests": @[@{
                                                           @"caption":interests[@"user-interest-one"],
                                           
                                                           }, @{
                                                           @"caption":interests[@"user-interest-two"]
                                                           }, @{
                                                           @"caption":interests[@"user-interest-three"]
                                                           }],
                                       @"mobile": [[NSUserDefaults standardUserDefaults] valueForKey:@"user-phone"],
                                       @"partyType": @"T",
                                       @"qualifications": @[]
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
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://wisekai.com:8085/api/v1/lesson/"]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary * newLesson = [[NSUserDefaults standardUserDefaults] valueForKey:@"new-lesson"];
    NSDictionary * newLessonSchedule = [[NSUserDefaults standardUserDefaults] valueForKey:@"new-lesson-schedule"];
    
    NSInteger  lessonDayNumber;
    
    if ([newLessonSchedule[@"lesson-day"] isEqualToString:@"Monday"]) {
        lessonDayNumber = 2;
    } else if ([newLessonSchedule[@"lesson-day"] isEqualToString:@"Tuesday"]){
        lessonDayNumber = 3;
    } else if ([newLessonSchedule[@"lesson-day"] isEqualToString:@"Wednesday"]){
        lessonDayNumber = 4;
    } else if ([newLessonSchedule[@"lesson-day"] isEqualToString:@"Thursday"]){
        lessonDayNumber = 5;
    } else if ([newLessonSchedule[@"lesson-day"] isEqualToString:@"Friday"]){
        lessonDayNumber = 6;
    } else if ([newLessonSchedule[@"lesson-day"] isEqualToString:@"Saturday"]){
        lessonDayNumber = 7;
    } else {
        lessonDayNumber = 1;
    }
    
    NSString * lessonTitle = [NSString stringWithFormat:@"%@", newLesson[@"lesson-name"]];
    NSString * lessonDesc = [NSString stringWithFormat:@"%@", newLesson[@"lesson-description"]];
    NSString * lessonObj = [NSString stringWithFormat:@"%@", newLesson[@"lesson-objective"]];
    NSNumber * lessonStu = [NSNumber numberWithLong: (long)newLesson[@"lesson-students"]];
    NSNumber * lessonDuration = [NSNumber numberWithLong: (long)newLesson[@"lesson-duration"]];
    NSNumber * lessonPrice = [NSNumber numberWithLong: (long)newLesson[@"lesson-price"]];
    
    int duration = [newLesson[@"lesson-duration"] intValue];
    int students = [newLesson[@"lesson-students"] intValue];
    int price = [newLesson[@"lesson-price"] intValue];
    
    NSNumber * durationNumber = [NSNumber numberWithInt:duration];
    /*
    NSLog(@"Number with Int: %@", [NSNumber numberWithInt:newLesson[@"lesson-duration"]]);
    
    */
    NSString * tagOne = [NSString stringWithFormat:@"%@", newLessonSchedule[@"lesson-tag-one"]];
    NSString * tagTwo = [NSString stringWithFormat:@"%@", newLessonSchedule[@"lesson-tag-two"]];
    NSString * tagThree = [NSString stringWithFormat:@"%@", newLessonSchedule[@"lesson-tag-three"]];
    
    NSString * lessonLongitude =  [[NSUserDefaults standardUserDefaults] valueForKey:@"lesson-longitude"];
    NSString * lessonLatitude =  [[NSUserDefaults standardUserDefaults] valueForKey:@"lesson-latitude"];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    dateString = [dateString stringByReplacingOccurrencesOfString:@" " withString:@"T"];
    dateString = [dateString stringByAppendingString:@".000Z"];
    
    NSDictionary * reqBody = @{
                               @"title": lessonTitle,
                               
                               @"description": lessonDesc,
                               
                               @"objective": lessonObj,
                               
                               @"active": @TRUE,
                               
                               @"classSize": [NSNumber numberWithInt:students],
                               
                               @"durationInMins": [NSNumber numberWithInt:duration],
                               
                               @"lat": lessonLatitude,
                               @"lon": lessonLongitude,
                               
                               @"price": [NSNumber numberWithInt:price],
                               
                               @"schedules": @[
                                       @{
                                           @"active": @TRUE,
                                           @"dayOfWeek": [NSNumber numberWithLong:lessonDayNumber],
                                           @"minuteOfDay_startTime": @90,
                                           @"createdDate": dateString,
                                           }
                                       ],
                               @"tags": @[ // At least Three Tags
                                       
                                       @{
                                           @"tag":tagOne
                                           },
                                       @{
                                           @"tag": tagTwo
                                           },
                                       @{
                                           @"tag": tagThree
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

+ (NSMutableURLRequest *)getNotifications {
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://wisekai.com:8085/api/v1/party/notification/"]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"GET"];
    
    return request;
}

@end
