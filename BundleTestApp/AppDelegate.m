//
//  AppDelegate.m
//  BundleTestApp
//
//  Created by Kevin Bradley on 12/4/20.
//  Copyright © 2020 nito. All rights reserved.
//

#import "AppDelegate.h"
#import <TVSettingKit/_TSKSplitViewController.h>

@interface AppDelegate ()
@property _TSKSplitViewController *rootViewController;
@end
@interface UIViewController (specifier)
-(NSDictionary *)specifier;
- (void)setSpecifier:(NSDictionary *)spec;
@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSBundle *bundle = [NSBundle bundleWithPath:@"/System/Library/PreferenceBundles/AppList.bundle"];
    [bundle load];
    if ([bundle isLoaded]) {
        UIViewController *ourVC = [bundle.principalClass new];
        NSDictionary *spec = @{@"ALAllowsSelection": @"1",
                               @"ALSettingsDefaultValue": @0,
                               @"ALSettingsKeyPrefix": @"SPL",
                               @"ALSettingsPath": @"/var/mobile/Library/Preferences/com.sample.allproc.plist",
                               @"ALSingleEnabledMode": (id)kCFBooleanFalse,
                               @"ALAllProcessesMode": (id)kCFBooleanTrue,
                               @"isController": (id)kCFBooleanTrue,
                               @"label": @"List Applications"};
                            
        [ourVC setSpecifier:spec];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:ourVC];
            _rootViewController = [[_TSKSplitViewController alloc] initWithNavigationController:navController];
    } else {
            UIViewController *blank = [[UIViewController alloc] init];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:blank];
            _rootViewController = [[_TSKSplitViewController alloc] initWithNavigationController:navController];
    }
    _window.rootViewController = _rootViewController;
    [_window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


@end
