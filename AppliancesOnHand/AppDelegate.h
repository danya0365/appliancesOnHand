//
//  AppDelegate.h
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/26/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabbarController.h"
@class DPLDeepLinkRouter;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) BaseTabbarController *baseTabbarController;
@property (assign, nonatomic) BOOL keyboardIsShowing;
@property (nonatomic) DPLDeepLinkRouter *router;

@end

