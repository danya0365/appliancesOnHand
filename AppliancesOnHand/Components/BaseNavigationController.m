//
//  BaseNavigationController.m
//  mam
//
//  Created by DEVTAB_006 on 11/21/2558 BE.
//  Copyright © 2558 DEVTAB_006. All rights reserved.
//

#import "define.h"
#import "BaseNavigationController.h"

@implementation BaseNavigationController

-(void)viewDidLoad
{
    [super viewDidLoad];

    //self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setTintColor:RGBACOLOR(255, 108, 74, 1.0f)];
    [self.navigationBar setBarTintColor:RGBACOLOR(255, 108, 74, 1.0f)];
    [self.navigationBar
        setTitleTextAttributes:
        @{
          NSForegroundColorAttributeName : [UIColor blackColor],
          NSFontAttributeName: [UIFont boldSystemFontOfSize:17]
        }
     ];
    
    //UIOffset backButtonTextOffset = UIOffsetMake(0, -60);
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:backButtonTextOffset forBarMetrics:UIBarMetricsDefault];
    
    //[self addCustomStatusBarView];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    if ( self.isStatusBarLight) {
        
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ( IS_IPHONE) {
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskLandscape;
}

-(void)addCustomStatusBarView
{
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    statusBarView.backgroundColor = UIColorFromRGB(0x27509b);
    statusBarView.autoresizesSubviews = YES;
    statusBarView.clipsToBounds = NO;
    statusBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:statusBarView];
}

@end
