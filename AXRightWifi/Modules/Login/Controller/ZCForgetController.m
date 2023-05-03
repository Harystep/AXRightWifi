//
//  ZCForgetController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCForgetController.h"

@interface ZCForgetController ()

@end

@implementation ZCForgetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavi];
}

- (void)configureNavi {
    self.showNavStatus = YES;
    self.title = @"";
}

@end
