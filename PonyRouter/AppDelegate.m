//
//  AppDelegate.m
//  PonyRouter
//
//  Created by 崔 明辉 on 15/3/5.
//  Copyright (c) 2015年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "PGRApplication.h"
#import "PGRNode.h"
#import "PGRConfiguration.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self addViewControllerNode];
    [self addPatternNode];
    [self addReturnableNode];
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([[PGRApplication sharedInstance] canOpenURL:url]) {
        [[PGRApplication sharedInstance] openURL:url];
    }
    return YES;
}



#pragma mark - Node

- (void)addViewControllerNode {
//    [[[PGRApplication sharedInstance] configure] setSchemes:@[@"demoApp"]];
    PGRNode *node = [[PGRNode alloc] init];
    node.identifier = @"sayhello";
    [node setExecutingBlock:^(NSURL *sourceURL, NSDictionary *params, NSObject *sourceObject) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:@"ViewController"];
        [(id)[[[[UIApplication sharedApplication] delegate] window] rootViewController]
         pushViewController:viewController animated:YES];
    }];
    [[PGRApplication sharedInstance] addNode:node];
}

- (void)addPatternNode {
    PGRNode *node = [[PGRNode alloc] initWithIdentifier:@".*?" scheme:@"test" usePattern:YES executingBlock:^(NSURL *sourceURL, NSDictionary *params, NSObject *sourceObject) {
        [[[UIAlertView alloc] initWithTitle:@"Hey!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }];
    [[PGRApplication sharedInstance] addNode:node];
}

- (void)addReturnableNode {
    PGRNode *node = [[PGRNode alloc] initWithIdentifier:@"kissme" returnableBlock:^id(NSURL *sourceURL, NSDictionary *params, NSObject *sourceObject) {
        return [NSString stringWithFormat:@"%@ kissed me.", params[@"someone"]];
    }];
    [[PGRApplication sharedInstance] addNode:node];
}

@end
