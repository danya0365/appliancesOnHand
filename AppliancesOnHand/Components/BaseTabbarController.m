//
//  BaseTabbarController.m
//  bike2day
//
//  Created by DEVTAB_006 on 1/12/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "define.h"
#import "BaseTabbarController.h"

@interface BaseTabbarController ()

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Backgound
    [self.tabBar setBarTintColor:UIColorFromRGB(0xFAFAFA)];

    //Selected Color
    [self.tabBar setTintColor:RGBACOLOR(255, 108, 74, 1.0f)];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UIStatusBarStyle)preferredStatusBarStyle{
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

@end
