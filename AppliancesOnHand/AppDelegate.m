//
//  AppDelegate.m
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/26/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#pragma mark - Core
#import "AppDelegate.h"
#import "BaseNavigationController.h"


#pragma mark - Import present view Controller
#import "ApplianceListViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self applicationReady];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - setupView

-(void)applicationReady
{
    [self switchToMainMenuFromViewController:nil];
}

-(void)switchToMainMenuFromViewController: (UIViewController *)viewController
{
    if ( viewController != nil ) {
        
        CATransition* transition = [CATransition animation];
        transition.duration = 0.3f;
        transition.type = kCATransitionFade;
        transition.subtype = kCATransitionFromBottom;
        [viewController.view.window.layer addAnimation:transition forKey:kCATransition];
        
    }
    
    [self setMainController];
}

-(void)setMainController
{

    ApplianceListViewController *applianceListViewController = [ApplianceListViewController defaultNib];
     BaseNavigationController *baseNavigationView = [[BaseNavigationController alloc] initWithRootViewController:applianceListViewController];
     [self.window setRootViewController:baseNavigationView];

}

@end
