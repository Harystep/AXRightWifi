//
//  AppDelegate.m
//  AXRightWifi
//
//  Created by oneStep on 2023/4/13.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    ViewController  *view = [[ViewController alloc] init];
    self.window.rootViewController = view;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
