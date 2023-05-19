//
//  AXConstantMacro.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#ifndef AXConstantMacro_h
#define AXConstantMacro_h

#define RGBA_COLOR(r, g, b, a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define rgba(r, g, b, a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB_COLOR(r,g,b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define COLOR_CONTENT     rgba(0, 0, 0, 1)
#define COLOR_SUB_CONTENT rgba(138, 138, 142, 1)

// 屏幕宽高
#define SCREEN_W    [UIScreen mainScreen].bounds.size.width
#define SCREEN_H    [UIScreen mainScreen].bounds.size.height
#define SCREEN_S    (SCREEN_W/375.0)

#define MAINWINDOW [UIApplication sharedApplication].keyWindow

// 自适应字体大小
#define AUTO_FONT_SIZE(size)           size*(SCREEN_W/375.0)

#define FONT_SYSTEM(size)  [UIFont systemFontOfSize:size]
#define FONT_BOLD(size)  [UIFont boldSystemFontOfSize:size]

// 自适应边距
#define AUTO_MARGIN(margin)            margin*(SCREEN_W/375.0)
#define AUTO_MARGINY(margin)            margin*(SCREEN_H/812.0)

#define checkSafeContent(content) [NSString safeStringWithConetent:content]
#define checkSafeURL(content) [NSURL URLWithString:[NSString safeStringWithConetent:content]]
#define checkSafeArray(data) [ZCBaseDataTool convertSafeArray:data]
#define checkSafeDict(data) [ZCBaseDataTool convertSafeDict:data]

// 刘海屏适配判断
#define iPhone_X ((UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) && (UIApplication.sharedApplication.statusBarFrame.size.height > 20.0))

// iPhone4S
#define iPhone_4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)

// 状态栏高度
#define STATUS_H          UIApplication.sharedApplication.statusBarFrame.size.height
#define STATUS_BAR_HEIGHT (iPhone_X ? 44.f : 20.f)

// 导航栏高度
#define NAV_BAR_HEIGHT        (STATUS_H + 44)
#define NAVIGATION_BAR_HEIGHT (iPhone_X ? 88.f : 64.f)

#define TAB_SAFE_BOTTOM (iPhone_X ? 34.0 : 0.0)
// tabBar高度
#define TAB_BAR_HEIGHT  (iPhone_X ? 83.f : 49.f)

#define kweakself(type) __weak typeof(type) weakself = type;

#define kIMAGE(imageStr)              [UIImage imageNamed:imageStr]

#endif /* AXConstantMacro_h */
