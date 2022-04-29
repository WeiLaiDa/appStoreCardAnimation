//
//  AppDelegate.m
//  APPSTORE
//
//  Created by Xuyiming on 2022/4/29.
//

#import "AppDelegate.h"
#import "TodayViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    TodayViewController * vc = [[TodayViewController alloc]init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}





@end
