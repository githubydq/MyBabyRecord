//
//  AppDelegate.m
//  DQBabyRecord
//
//  Created by youdingquan on 16/4/13.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "AppDelegate.h"
#import <MMDrawerController.h>
#import "LeftDrawerViewController.h"
#import "MainViewController.h"
#import "DQWelcomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark -
#pragma mark 创建抽屉库
-(void)intoDrawer{
    MainViewController * center = [[MainViewController alloc] init];
    
    LeftDrawerViewController * left = [[LeftDrawerViewController alloc] init];
    
    MMDrawerController * drawer = [[MMDrawerController alloc] initWithCenterViewController:center leftDrawerViewController:left rightDrawerViewController:nil];
    drawer.maximumLeftDrawerWidth = SCREEN_WIDTH*5.0/7.0;
    [drawer setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeBezelPanningCenterView];
    [drawer setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    self.window.rootViewController = drawer;
}

#pragma mark -
#pragma mark appdelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    DQWelcomeViewController * welcome = [[DQWelcomeViewController alloc] init];
    NSString * bgImage = [NSString stringWithFormat:@"%@/welcomebg.jpg",[[NSBundle mainBundle] pathForResource:@"image" ofType:@"bundle"]];
    [welcome mySetBackImage:[UIImage imageWithContentsOfFile:bgImage]];
    self.window.rootViewController = welcome;
    
    [self.window makeKeyAndVisible];
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
