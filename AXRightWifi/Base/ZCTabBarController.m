//
//  ZCTabBarController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCTabBarController.h"
#import "ZCMyController.h"
#import "ZCFlowController.h"
#import "ZCShopController.h"
#import "ZCHomeController.h"

@interface ZCTabBarController ()<UITabBarControllerDelegate>

@end

@implementation ZCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 13.0, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
    self.delegate = self;
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_W, TAB_BAR_HEIGHT);
    view.backgroundColor = UIColor.whiteColor;
    [[UITabBar appearance] insertSubview:view atIndex:0];
    self.tabBar.clipsToBounds = YES;
    
    [self setupChildControllers];
        
}

// 添加 tabBar 子控制器
- (void)setupChildControllers {
    ZCHomeController   *homeVc  = [[ZCHomeController alloc] init];
    ZCBaseNavController *homeNav = [[ZCBaseNavController alloc] initWithRootViewController:homeVc];
    [self setupChildViewController:homeVc title:NSLocalizedString(@"首页", nil) imageName:@"tabbar_home_nor" seleceImageName:@"tabbar_home_sel"];
    
    ZCFlowController   *flowVc  = [[ZCFlowController alloc] init];
    ZCBaseNavController *flowNav = [[ZCBaseNavController alloc] initWithRootViewController:flowVc];
    [self setupChildViewController:flowVc title:NSLocalizedString(@"领流量", nil) imageName:@"tabbar_class_nor" seleceImageName:@"tabbar_class_sel"];
    
    ZCShopController   *shopVc  = [[ZCShopController alloc] init];
    ZCBaseNavController *shopNav = [[ZCBaseNavController alloc] initWithRootViewController:shopVc];
    [self setupChildViewController:shopVc title:NSLocalizedString(@"9元购", nil) imageName:@"tabbar_shop_nor" seleceImageName:@"tabbar_shop_sel"];
    
    ZCMyController   *myVc  = [[ZCMyController alloc] init];
    ZCBaseNavController *myNav = [[ZCBaseNavController alloc] initWithRootViewController:myVc];
    [self setupChildViewController:myVc title:NSLocalizedString(@"我的", nil) imageName:@"tabbar_my_nor" seleceImageName:@"tabbar_my_sel"];
        
    self.viewControllers = @[homeNav, flowNav, shopNav, myNav];
    self.selectedIndex = 0;
}

- (UIImage *)convertImageAlpha:(UIImage *)image {
    return image;
}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName {
    
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [[UIImage imageByApplyingAlpha:1.0 image:[UIImage imageNamed:imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageByApplyingAlpha:1.0 image:[UIImage imageNamed:selectImageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
//    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    if (@available(iOS 13.0, *)) {
        [ZCConfigColor txtColor];
        self.tabBar.unselectedItemTintColor = rgba(32, 33, 33, 0.4);//未选中时文字颜色
        self.tabBar.tintColor = [ZCConfigColor txtColor];//选中时文字颜色
    } else {
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [ZCConfigColor txtColor]} forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : rgba(32, 33, 33, 0.4)} forState:UIControlStateNormal];
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}


@end
