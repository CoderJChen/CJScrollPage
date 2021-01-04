//
//  CJAppDelegate.m
//  CJScrollPage
//
//  Created by coderCJ on 12/28/2020.
//  Copyright (c) 2020 coderCJ. All rights reserved.
//

#import "CJAppDelegate.h"
#import "SegmentVC.h"
@implementation CJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    SegmentVC * segmentVC = [[SegmentVC alloc] init];
    self.window.rootViewController = segmentVC;
    [segmentVC setUpWithItems:@[@"推荐", @"订阅", @"历史",@"推荐", @"订阅", @"历史"] childVC:@[[[UIViewController alloc]init],[[UIViewController alloc]init],[[UIViewController alloc]init],[[UIViewController alloc]init],[[UIViewController alloc]init],[[UIViewController alloc]init]] andSegBarPositionTop:88 andSegmentH:44];
    [segmentVC.segmentBar updateWithConfig:^(CJSegmentBarConfig * _Nonnull config) {
        config.segmentBarBackColor = [UIColor greenColor];
        config.itemSelectColor = [UIColor purpleColor];

    }];
    [self.window makeKeyWindow];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
