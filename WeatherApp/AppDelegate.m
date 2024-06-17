//
//  AppDelegate.m
//  WeatherApp
//
//  Created by Andres on 2024/4/22.
//

#import "AppDelegate.h"
#import "LaunchVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    LaunchVC *launchvc = [LaunchVC new];
    self.window.rootViewController = launchvc;
    [self.window makeKeyAndVisible];
    
    return YES;
}
@end
