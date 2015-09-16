//
//  AppDelegate.m
//  CrashReporter
//
//  Created by qihaijun on 9/16/15.
//  Copyright (c) 2015 VictorChee. All rights reserved.
//

#import "AppDelegate.h"

#import "KSCrash.h"
#import "KSCrashInstallationStandard.h"
#import "KSCrashInstallationQuincyHockey.h"
#import "KSCrashInstallationEmail.h"
#import "KSCrashInstallationVictory.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (KSCrashInstallation *)makeEmailInstallation
{
    NSString *emailAddress = @"2316828815@qq.com";
    
    KSCrashInstallationEmail *email = [KSCrashInstallationEmail sharedInstance];
    email.recipients = @[emailAddress];
    email.subject = @"崩溃报告";
    email.message = @"这是一小份崩溃报告";
    email.filenameFmt = @"crash-report-%d.txt.gz";
    [email addConditionalAlertWithTitle:@"检测到崩溃" message:@"是否要发送崩溃报告" yesAnswer:@"发送" noAnswer:@"算了"];
    [email setReportStyle:KSCrashEmailReportStyleApple useDefaultFilenameFormat:YES];
    return email;
}

- (void)installCreashHandler
{
    KSCrashInstallation *crashInstallation = [self makeEmailInstallation];
    [crashInstallation install];
    [KSCrash sharedInstance].deleteBehaviorAfterSendAll = KSCDeleteOnSucess;
    [crashInstallation sendAllReportsWithCompletion:^(NSArray *filteredReports, BOOL completed, NSError *error) {
        if (completed) {
            NSLog(@"Sent %lu reports", (unsigned long)filteredReports.count);
        } else {
            NSLog(@"Failed to send reports: %@", error);
        }
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self installCreashHandler];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
