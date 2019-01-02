//
//  AppDelegate.m
//  wisekai-poc
//
//  Created by Ahmed Ali Zafar on 21/11/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKCoreKit/FBSDKProfile.h>
#import "UserSelectionViewController.h"

#import <UserNotifications/UserNotifications.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    /*
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString * userType = [userDefaults valueForKey:@"user-type"];
    
    NSString * bearerToken = [userDefaults valueForKey:@"bearer-token"];
    
    if (bearerToken && bearerToken.length > 0 && userType && userType.length > 0) {
        
        if ([userType isEqualToString:@"student"]) {
            [self presentStudentStoryboard];
        } else if ([userType isEqualToString:@"teacher"]) {
            [self presentTeacherStoryboard];
        } else {
            [self presentUserSelection];
        }
        
    } else if ([FBSDKAccessToken currentAccessToken] && (userType.length > 0)) {
        //Take User TO mainVC - Extra Logic in future to select between student and teacher
        
        if ([userType isEqualToString:@"student"]) {
            
            [self presentStudentStoryboard];
            
        } else if ([userType isEqualToString:@"teacher"]) {
            
            [self presentTeacherStoryboard];
            
        } else {
            [self presentUserSelection];
        }
    } else {
        
        [self presentUserSelection];
    }*/
    
    UIStoryboard * devBoard = [UIStoryboard storyboardWithName:@"APITest" bundle:nil];
    //UIStoryboard * devBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    self.window.rootViewController = devBoard.instantiateInitialViewController;
    
    //[self presentTeacherStoryboard];
    
    [self.window makeKeyAndVisible];
    
    //[self registerForNotifications];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:app openURL:url options:options];
    [[FBSDKApplicationDelegate sharedInstance] application:app openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    
    return handled;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //UA_LTRACE(@"APNS device token: %@", deviceToken);
    
    NSString * deviceTokenString = [[[[deviceToken description]
                                      stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                     stringByReplacingOccurrencesOfString: @">" withString: @""]
                                    stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    [self uploadPushNotificationDeviceToken:deviceTokenString];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    NSLog(@"Error: %@", error.localizedDescription);
}

#pragma mark - Push Notifications


- (void)registerForNotifications {
    
    UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
    
    if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
        NSLog(@"Application already registered");
    } else {
        
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"Permission Given");
                [[UIApplication sharedApplication] registerForRemoteNotifications];
                
            } else {
                NSLog(@"Permission Not given");
            }
        }];
    }
}


#pragma mark - API

- (void)uploadPushNotificationDeviceToken:(NSString *)token {
    
    NSString * urlString = [NSString stringWithFormat:@"http://wisekai.com:8085/api/v1/setup/addToken/%@", token];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    NSURL * url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:5.0];
    
    sessionConfiguration.allowsCellularAccess = YES;
    
    NSURLSession * urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    [[urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            NSLog(@"Response Received");
            
        }
    }] resume];
    
}

#pragma mark - Helpers

- (void)presentStudentStoryboard {
    
    UIStoryboard * studentBoard = [UIStoryboard storyboardWithName:@"Student" bundle:nil];
    self.window.rootViewController = studentBoard.instantiateInitialViewController;
}


- (void)presentTeacherStoryboard {
    
    UIStoryboard * teacherBoard = [UIStoryboard storyboardWithName:@"Teacher" bundle:nil];
    self.window.rootViewController = teacherBoard.instantiateInitialViewController;
}



- (void)presentUserSelection {
    
    UIStoryboard * userSelectionBoard = [UIStoryboard storyboardWithName:@"UserSelection" bundle:nil];
    self.window.rootViewController = userSelectionBoard.instantiateInitialViewController;
}


@end
