//
//  AppDelegate.m
//  AXRightWifi
//
//  Created by oneStep on 2023/4/13.
//

#import "AppDelegate.h"
#import "ZCLoginController.h"
#import "ZCTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [HBRouter loadConfigPlist:nil];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self initializationWindow];
    return YES;
}

- (void)initializationWindow {
    [IQKeyboardManager sharedManager].enable = YES;
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = NSLocalizedString(@"确定", nil);
    // 初始化窗口
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    // 添加跟视图控制器
    NSLog(@"token--->%@", kUserInfo.token);
    if (kUserInfo.token.length > 0) {
        kUserInfo.status = NO;
        ZCTabBarController *tabBar = [[ZCTabBarController alloc] init];
        self.window.rootViewController  = tabBar;
        [self.window makeKeyAndVisible];
    } else {
        ZCLoginController *login = [[ZCLoginController alloc] init];
        ZCBaseNavController *nav = [[ZCBaseNavController alloc] initWithRootViewController:login];
        self.window.rootViewController  = nav;
        [self.window makeKeyAndVisible];
    }
    
}

@end
