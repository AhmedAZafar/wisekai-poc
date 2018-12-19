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
    
    if ([FBSDKAccessToken currentAccessToken]) {
        //Take User TO mainVC - Extra Logic in future to select between student and teacher
        UIStoryboard * studentStoryBoard = [UIStoryboard storyboardWithName:@"Student" bundle:nil];
        self.window.rootViewController = studentStoryBoard.instantiateInitialViewController;
        
    } else {
        //Take them to Login VC
        UserSelectionViewController * userSVC = [[UserSelectionViewController alloc] initWithNibName:@"UserSelectionViewController" bundle:nil];
        self.window.rootViewController = userSVC;
    }
    
    [self.window makeKeyAndVisible];
    
    [self registerForNotifications];
    
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
    
    NSLog(@"deivce Token is: %@", deviceToken);
    
    NSString * deviceTokenString = [[[[deviceToken description]
                                      stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                     stringByReplacingOccurrencesOfString: @">" withString: @""]
                                    stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"The generated device token string is : %@",deviceTokenString);
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





@end
