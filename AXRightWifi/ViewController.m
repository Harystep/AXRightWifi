//
//  ViewController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/4/13.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_top_bg"]];
    [self.view addSubview:icon];
}


@end
