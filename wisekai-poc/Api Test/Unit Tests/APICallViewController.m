//
//  APICallViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 28/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "APICallViewController.h"
#import "APICalls.h"

@interface APICallViewController ()
{
    NSString * studentBearerToken;
    NSString * teacherBearerToken;
}

@end

@implementation APICallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    studentBearerToken = @"935cac27-dd0d-4f22-8c24-8361f3e2a70a";
    teacherBearerToken = @"70d5a563-9f44-47a6-add3-6573299ca00b";
}

- (IBAction)createStudent:(id)sender {
    
    //Set up your request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://wisekai.com:8085/api/v1/auth/"]];
    
    // Set your user login credentials
    [request setValue:[NSString stringWithFormat:@"Basic QU5PTllNOkFOT05ZTSFAIyQ="] forHTTPHeaderField:@"Authorization"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary * reqBody = @{
                               
                               @"username": @"ahmedStudent",
                               @"password": @"passwordTest",
                               @"party": @{
                                       
                                       @"dob": @"2018-12-28T19:01:41.996Z",
                                       @"email": @"a@b.com",
                                       @"firstName": @"firstName",
                                       @"lastName": @"lastName",
                                       @"gender": @"male",
                                       @"interests": @[
                                               @{
                                                   @"caption":@"Entertainment"
                                                   },
                                               @{
                                                   @"caption":@"Information Technology"
                                                   },
                                               @{
                                                   @"caption":@"Outdoor Sports"
                                                   }
                                               ],
                                       @"mobile": @"+447397107764",
                                       @"partyType": @"S",
                                       @"qualifications": @[]
                                       }
                               };
    
    NSError * jsonError;
    NSData * postData = [NSJSONSerialization dataWithJSONObject:reqBody options:NSJSONWritingSortedKeys error:&jsonError];
    
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    
    // Send your request asynchronously
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *responseCode, NSData *responseData, NSError *responseError) {
        if ([responseData length] > 0 && responseError == nil){
            
            NSError * jsonError;
            
            NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&jsonError];
            
            NSLog(@"Response Dict:  %@", response);
            
            
        }else if ([responseData length] == 0 && responseError == nil){
            NSLog(@"data error: %@", responseError);
            
            
            // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Error accessing the data" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
            //[alert show];
            //[alert release];
        }else if (responseError != nil && responseError.code == NSURLErrorTimedOut){
            NSLog(@"data timeout: %ld", (long)NSURLErrorTimedOut);
            //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"connection timeout" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
            //[alert show];
            //[alert release];
            
        }else if (responseError != nil){
            
            NSLog(@"data download error: %@",responseError);
            
        }
        
    }];
    
    
}

- (IBAction)createTeacher:(id)sender {
    
    //Set up your request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://wisekai.com:8085/api/v1/auth/"]];
    
    // Set your user login credentials
    [request setValue:[NSString stringWithFormat:@"Basic QU5PTllNOkFOT05ZTSFAIyQ="] forHTTPHeaderField:@"Authorization"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary * reqBody = @{
                               
                               @"username": @"ahmed",
                               @"password": @"passwordTest",
                               @"party": @{
                                       
                                       @"dob": @"2018-12-28T19:01:41.996Z",
                                       @"email": @"a@b.com",
                                       @"firstName": @"firstName",
                                       @"lastName": @"lastName",
                                       @"gender": @"male",
                                       @"interests": @[],
                                       @"mobile": @"+447397107764",
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
    
    // Send your request asynchronously
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *responseCode, NSData *responseData, NSError *responseError) {
        if ([responseData length] > 0 && responseError == nil){
            
            NSError * jsonError;
            
            NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&jsonError];
            
            NSLog(@"Response Dict:  %@", response);
            
            
        }else if ([responseData length] == 0 && responseError == nil){
            NSLog(@"data error: %@", responseError);
            
            
            // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Error accessing the data" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
            //[alert show];
            //[alert release];
        }else if (responseError != nil && responseError.code == NSURLErrorTimedOut){
            NSLog(@"data timeout: %ld", (long)NSURLErrorTimedOut);
            //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"connection timeout" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
            //[alert show];
            //[alert release];
            
        }else if (responseError != nil){
            
            NSLog(@"data download error: %@",responseError);
            
        }
        
    }];
    
}
- (IBAction)updateTeacher:(id)sender {
}
- (IBAction)updateStudent:(id)sender {
}
- (IBAction)getStudentLessons:(id)sender {
    
    //Set up your request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://wisekai.com:8085/api/v1/lesson/"]];
    
    // Set your user login credentials
    [request setValue:[NSString stringWithFormat:@"Bearer %@", studentBearerToken] forHTTPHeaderField:@"Authorization"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if ([data length] > 0) {
            
            NSLog(@"Got something for lessosn list of students");
            
            NSError * responseReadError;
            NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&responseReadError];
            
            NSLog(@"Response dict for lessons for student %@", responseDict);
        }
    }];
    
    
}
- (IBAction)getTeacherLessons:(id)sender {
    //Set up your request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://wisekai.com:8085/api/v1/lesson/"]];
    
    // Set your user login credentials
    [request setValue:[NSString stringWithFormat:@"Bearer %@", teacherBearerToken] forHTTPHeaderField:@"Authorization"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if ([data length] > 0) {
            
            NSLog(@"Got something for lesson list of teachers");
            
            NSError * responseReadError;
            NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&responseReadError];
            
            NSLog(@"Response dict for lessons for teacher %@", responseDict);
        }
    }];
}
- (IBAction)addLesson:(id)sender {
    
    //Set up your request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://wisekai.com:8085/api/v1/lesson/"]];
    
    // Set your user login credentials
    [request setValue:[NSString stringWithFormat:@"Bearer %@", teacherBearerToken] forHTTPHeaderField:@"Authorization"];
    
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
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if ([data length] > 0) {
            NSError * responseReadError;
            NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&responseReadError];
            
            NSLog(@"Lesson Add : %@", responseDict);
            
            
        }
    }];
    
    
    
    
}
- (IBAction)createBoking:(id)sender {
}
- (IBAction)didPressSearchLesson:(id)sender {
    
    if (self.searchTextfield.text.length > 0) {
        
        //Set up your request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wisekai.com:8085/api/v1/lesson/find/%@/", self.searchTextfield.text]]];
        
        // Set your user login credentials
        [request setValue:[NSString stringWithFormat:@"Bearer %@", studentBearerToken] forHTTPHeaderField:@"Authorization"];
        
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPMethod:@"GET"];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            if ([data length] > 0) {
                
                NSLog(@"Got some search results for student");
                
                NSError * responseReadError;
                NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&responseReadError];
                
                NSLog(@"Response dict for search result for student %@", responseDict);
            }
        }];
        
        
    }
    
}
- (IBAction)didPressSlotSearch:(id)sender {
    //if (self.slotTextfield.text.length > 0) {
        
        //Set up your request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wisekai.com:8085/api/v1/lesson/slots/9/"]]];
        
        // Set your user login credentials
        [request setValue:[NSString stringWithFormat:@"Bearer %@", studentBearerToken] forHTTPHeaderField:@"Authorization"];
        
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPMethod:@"GET"];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            if ([data length] > 0) {
                
                NSLog(@"Got some slot results for student");
                
                NSError * responseReadError;
                NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&responseReadError];
                
                NSLog(@"Response dict for slot result for student %@", responseDict);
            }
        }];
        
    //}
}
- (IBAction)didSelectSubscribeForSlot:(id)sender {
    
    //Set up your request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wisekai.com:8085/api/v1/lesson/subscription/"]]];
    
    // Set your user login credentials
    [request setValue:[NSString stringWithFormat:@"Bearer %@", studentBearerToken] forHTTPHeaderField:@"Authorization"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"POST"];
    
    NSArray
    * reqBody = @[@{
                               @"date" : @"2019-02-21T22:26:30.108+0000",
                               @"durationInMinutes" : @80,
                               @"endTime_minuteOfDay" : @170,
                               @"lessonId" : @9,
                               @"numSubscribers" : @7,
                               @"scheduleId" : @10,
                               @"startTime_minuteOfDay" : @90,
                               @"vacancy" : @20
                               }];
    
    NSError * jsonError;
    NSData * reqBodyData = [NSJSONSerialization dataWithJSONObject:reqBody options:NSJSONWritingSortedKeys error:&jsonError];
    
    [request setHTTPBody:reqBodyData];
    
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if ([data length] > 0) {
            
            NSLog(@"Got some subscription results for student");
            
            NSError * responseReadError;
            NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&responseReadError];
            
            NSLog(@"Response dict for subscription result for student %@", responseDict);
        }
    }];
    
}
- (IBAction)didSelectListSubscriptions:(id)sender {
    
    //Set up your request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wisekai.com:8085/api/v1/lesson/subscription/"]]];
    
    // Set your user login credentials
    [request setValue:[NSString stringWithFormat:@"Bearer %@", studentBearerToken] forHTTPHeaderField:@"Authorization"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if ([data length] > 0) {
            
            NSLog(@"Got some booking results for student");
            
            NSError * responseReadError;
            NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&responseReadError];
            
            NSLog(@"Response dict for booking result for student %@", responseDict);
        }
    }];
}

@end
