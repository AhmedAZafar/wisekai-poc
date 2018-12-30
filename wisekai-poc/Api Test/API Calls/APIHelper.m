//
//  APIHelper.m
//  wisekai-poc
//
//  Created by Ahmed on 29/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "APIHelper.h"

@implementation APIHelper

+ (NSString *)getBasicAuthStringFromUserDefaults {
    
    NSString * email = [[NSUserDefaults standardUserDefaults] valueForKey:@"user-email"];
    NSString * password = [[NSUserDefaults standardUserDefaults] valueForKey:@"user-password"];
    
    NSString * authString = [NSString stringWithFormat:@"%@:%@", email, password];
    
    NSData * authData = [authString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
}

+ (NSURLSession *)getWisekaiDefaultSession {
    
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[self getWisekaiSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    return session;
    
}

+ (NSURLSessionConfiguration *)getWisekaiSessionConfiguration {
    
    NSURLSessionConfiguration * sessionConf = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    sessionConf.allowsCellularAccess = YES;
    
    return sessionConf;
}

@end
