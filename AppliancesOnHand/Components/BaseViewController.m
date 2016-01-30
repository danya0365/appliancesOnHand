//
//  BaseViewController.m
//  mam
//
//  Created by DEVTAB_006 on 11/18/2558 BE.
//  Copyright © 2558 DEVTAB_006. All rights reserved.
//

#import "define.h"
#import "AppDelegate.h"
#import "BaseViewController.h"
#import <CRToast/CRToast.h>
#import <AFNetworking/AFNetworking.h>
#import "User.h"
#import "UITabBarController+hidable.h"
#import <MBProgressHUD/MBProgressHUD.h>

#import <LBXScan/LBXScanViewStyle.h>
#import <LBXScan/LBXScanResult.h>
#import <LBXScan/LBXScanWrapper.h>

#import "QRScanViewController.h"
#import "BaseNavigationController.h"

#define kShowToastMessageToastAnimationDirectionTopKey @"kShowToastMessageToastAnimationDirectionTopKey"

@interface BaseViewController () <UIWebViewDelegate, UIAlertViewDelegate>
{
    BOOL _hideTabBar;
}
@end

@implementation BaseViewController


#pragma mak - Utility

+(instancetype)defaultNib
{
    return [[[self class] alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+(instancetype)loadWithNib:(NSString *)nibName
{
    return [[[self class] alloc] initWithNibName:nibName bundle:nil];
}

-(CGSize )getViewSize: (id )view
{
    CGSize size = CGSizeZero;
    if ( [view isKindOfClass:[UILabel class]]) {
        
        UILabel *label = (UILabel *)view;
        size = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:label.font } context:nil].size;
    }
    return size;
}


-(void)hideKeyboard
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (appDelegate.keyboardIsShowing) {
        [self.view endEditing:YES];
    }
}


- (void)refresh:(UIRefreshControl *)refreshControl {
    // Do your job, when done:
    [refreshControl endRefreshing];
    [self refreshTableView];
    [self refreshCollectionView];
}

-(void)refreshTableView
{
    //need implement in subclass
}
-(void)refreshCollectionView
{
    //need implement in subclass
}

-(void)contentSizeDidChangeNotification:(NSNotification*)notification{
    [self contentSizeDidChange:notification.userInfo[UIContentSizeCategoryNewValueKey]];
}

-(void)contentSizeDidChange:(NSString *)size{
    //Implement in subclass
}


#pragma mark -setup view

- (void)setNavigationBarMenuButton {
    
}

-(void)loadViewFromInit
{
    if ( SYSTEM_VERSION_LESS_THAN(@"9.0")) {
        _bounds = [[UIScreen mainScreen] applicationFrame];
    }
    else
    {
        _bounds = [[UIScreen mainScreen] bounds];
    }
    
    
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        //_bounds =  CGRectMake(_bounds.origin.x, _bounds.origin.y, _bounds.size.height, _bounds.size.width);
    }
    
    
    if ( self.view == nil ) {
        
        self.view = [[UIView alloc] initWithFrame:_bounds];
        self.view.backgroundColor = [UIColor whiteColor];
    }

}


- (CGRect)statusBarFrameViewRect:(UIView*)view
{
    /*
     CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
     CGRect statusBarWindowRect = [view.window convertRect:statusBarFrame fromWindow: nil];
     CGRect statusBarViewRect = [view convertRect:statusBarWindowRect fromView: nil];
     */
    
    CGRect statusBarViewRect = [[UIApplication sharedApplication] statusBarFrame];
    return statusBarViewRect;
}

- (void)setNavigationBarTransparent {
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)setNavigationBarBackground {
    
    /*
     CAGradientLayer *gradientLayer = [CAGradientLayer layer];
     CGRect rect = self.navigationController.navigationBar.frame;
     gradientLayer.frame = rect;
     
     gradientLayer.colors = @[ (__bridge id)UIColorFromRGB(0x3282e0).CGColor,
     (__bridge id)UIColorFromRGB(0x27509b).CGColor ];
     gradientLayer.startPoint = CGPointMake(0.0, 0.5);
     gradientLayer.endPoint = CGPointMake(1.0, 0.5);
     
     UIGraphicsBeginImageContext(gradientLayer.frame.size);
     [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
     UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     
     [self.navigationController.navigationBar setBackgroundImage:gradientImage forBarMetrics:UIBarMetricsDefault];
     
     
     self.navigationController.navigationBar.shadowImage = [UIImage new];
     self.navigationController.navigationBar.translucent = NO;
     */
    
    
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xffffff);
    //self.navigationController.navigationBar.shadowImage = [UIImage new];
    //self.navigationController.navigationBar.translucent = NO;
    
}

- (void)setNavigationBarLeftButton {
    
    if ( [self backViewController] ) {
        
        [self setBarBackButton];
    }
    else
    {
        [self setBarCloseButton];
    }
    
}

- (void)setNavigationBarRightButton {
    
}


-(void)setBarBackButton
{
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = NSLocalizedString(@"back_menu_title", nil);
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
}


-(void)setBarCloseButton
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"close_menu_title", nil) style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
}

-(void)setTransclucentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.translucent = YES;
}

-(void)setDisableTransclucentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationController.navigationBar.translucent = NO;
}


#pragma mark - Life Cyccle

-(void)loadView
{
    [super loadView];
    
    [self loadViewFromInit];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ( _refreshControl != nil ) {
        [_refreshControl endRefreshing];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(contentSizeDidChangeNotification:)
     name:UIContentSizeCategoryDidChangeNotification
     object:nil];

    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [self setNavigationBarLeftButton];
    [self setNavigationBarRightButton];
    [self setNavigationBarBackground];
    [self setDisableTransclucentView];
    
    if ( _formatterCurrency == nil ) {
        _formatterCurrency = [[NSNumberFormatter alloc] init];
        _formatterCurrency.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"];
        _formatterCurrency.paddingPosition = NSNumberFormatterPadAfterSuffix;
        _formatterCurrency.numberStyle = NSNumberFormatterCurrencyStyle;
        [_formatterCurrency setMaximumFractionDigits:2];
    }
    
    if ( _numberFormatter == nil ) {
        
        _numberFormatter = [[NSNumberFormatter alloc] init];
        [_numberFormatter setPositiveFormat:@"##,##,###"];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]
     removeObserver:self];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    //The device has already rotated, that's why this method is being called.
    UIInterfaceOrientation toOrientation   = [[UIDevice currentDevice] orientation];
    //fixes orientation mismatch (between UIDeviceOrientation and UIInterfaceOrientation)
    if (toOrientation == UIInterfaceOrientationLandscapeRight) toOrientation = UIInterfaceOrientationLandscapeLeft;
    else if (toOrientation == UIInterfaceOrientationLandscapeLeft) toOrientation = UIInterfaceOrientationLandscapeRight;
    
    UIInterfaceOrientation fromOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    [self willRotateToInterfaceOrientation:toOrientation duration:0.0];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self willAnimateRotationToInterfaceOrientation:toOrientation duration:[context transitionDuration]];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self didRotateFromInterfaceOrientation:fromOrientation];
    }];
    
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self setNavigationBarBackground];
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

#pragma mark - Button Action
-(void)closeButtonPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)backButtonPress:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - Reachable
- (BOOL) isConnected {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

#pragma mark - Set Variable

-(void)addRefreshControlToTableView: (UITableView *)tableView
{
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:_refreshControl];
}

-(void)addRefreshControlToCollectionView:(UICollectionView *)collectionVIew
{
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [collectionVIew addSubview:_refreshControl];
}


#pragma mark - UIWebView Delegate
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    //[self.activityIndicatorView stopAnimating];
    [self hideActivityIndicator];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    //[self.activityIndicatorView startAnimating];
    [self showActivityIndicator];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    //[self.activityIndicatorView stopAnimating];
    [self hideActivityIndicator];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}


#pragma mark - Toast
-(void)presentInfoToastAnimationDirectionTopWithMessage:(NSString *)message
{
    [CRToastManager dismissAllNotificationsWithIdentifier:kShowToastMessageToastAnimationDirectionTopKey animated:YES];
    NSDictionary *toastOptions = @{
                                   kCRToastIdentifierKey : kShowToastMessageToastAnimationDirectionTopKey,
                                   kCRToastTextKey : message,
                                   kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                   kCRToastTextColorKey : [UIColor whiteColor],
                                   kCRToastBackgroundColorKey : UIColorFromRGB(0x09723A),
                                   kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),
                                   kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),
                                   kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                                   kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop) ,
                                   kCRToastTimeIntervalKey : @(2.0f) ,
                                   kCRToastNotificationPreferredHeightKey : @(24.0f) ,
                                   kCRToastUnderStatusBarKey : @(NO) ,
                                   kCRToastNotificationTypeKey : @(CRToastTypeCustom)
                                   };
    
    [CRToastManager showNotificationWithOptions:toastOptions
                                completionBlock:^{
                                    //NSLog(@"Login Failed");
                                }];
}

-(void)presentAttentionToastAnimationDirectionTopWithMessage:(NSString *)message
{
    [CRToastManager dismissAllNotificationsWithIdentifier:kShowToastMessageToastAnimationDirectionTopKey animated:YES];
    NSDictionary *toastOptions = @{
                                   kCRToastIdentifierKey : kShowToastMessageToastAnimationDirectionTopKey,
                                   kCRToastTextKey : message,
                                   kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                   kCRToastTextColorKey : [UIColor whiteColor],
                                   kCRToastBackgroundColorKey : [UIColor orangeColor],
                                   kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),
                                   kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),
                                   kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                                   kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop) ,
                                   kCRToastTimeIntervalKey : @(2.0f) ,
                                   kCRToastNotificationPreferredHeightKey : @(24.0f) ,
                                   kCRToastUnderStatusBarKey : @(NO) ,
                                   kCRToastNotificationTypeKey : @(CRToastTypeCustom)
                                   };
    
    [CRToastManager showNotificationWithOptions:toastOptions
                                completionBlock:^{
                                    //NSLog(@"Login Failed");
                                }];
    
}

- (void)presentSuccessToastAnimationDirectionTopWithMessage: (NSString *)message
{
    [CRToastManager dismissAllNotificationsWithIdentifier:kShowToastMessageToastAnimationDirectionTopKey animated:YES];
    NSDictionary *toastOptions = @{
                                   kCRToastIdentifierKey : kShowToastMessageToastAnimationDirectionTopKey,
                                   kCRToastTextKey : message,
                                   kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                   kCRToastTextColorKey : [UIColor whiteColor],
                                   kCRToastBackgroundColorKey : UIColorFromRGB(0x09723A),
                                   kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),
                                   kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),
                                   kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                                   kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop) ,
                                   kCRToastTimeIntervalKey : @(2.0f) ,
                                   kCRToastNotificationPreferredHeightKey : @(24.0f) ,
                                   kCRToastUnderStatusBarKey : @(NO) ,
                                   kCRToastNotificationTypeKey : @(CRToastTypeCustom)
                                   };
    
    [CRToastManager showNotificationWithOptions:toastOptions
                                completionBlock:^{
                                    //NSLog(@"Login Failed");
                                }];
}
- (void)presentErrorToastAnimationDirectionTopWithMessage: (NSString *)message
{
    [CRToastManager dismissAllNotificationsWithIdentifier:kShowToastMessageToastAnimationDirectionTopKey animated:YES];
    NSDictionary *toastOptions = @{
                                   kCRToastIdentifierKey : kShowToastMessageToastAnimationDirectionTopKey,
                                   kCRToastTextKey : message,
                                   kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                   kCRToastTextColorKey : [UIColor whiteColor],
                                   kCRToastBackgroundColorKey : [UIColor redColor],
                                   kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),
                                   kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),
                                   kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                                   kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop) ,
                                   kCRToastTimeIntervalKey : @(2.0f) ,
                                   kCRToastNotificationPreferredHeightKey : @(24.0f) ,
                                   kCRToastUnderStatusBarKey : @(NO) ,
                                   kCRToastNotificationTypeKey : @(CRToastTypeCustom)
                                   };
    
    [CRToastManager showNotificationWithOptions:toastOptions
                                completionBlock:^{
                                    //NSLog(@"Login Failed");
                                }];
}

#pragma mark - Indicator

-(void)showActivityIndicator
{
    //[self.activityIndicatorView startAnimating];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)hideActivityIndicator
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //[self.activityIndicatorView stopAnimating];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
    });
}


#pragma mark - Error Utility
-(NSString *)getErrorMessage:(NSError *) error
{
    NSString *errorString = @"";
    
    errorString = error.description;
    
    NSDictionary *userInfo = error.userInfo;
    
    NSLog(@"userInfo: %@", userInfo);
    
    if ( userInfo != nil ) {
        
        NSString *localizedDescription = [userInfo objectForKey:@"NSLocalizedDescription"];
        
        if ( localizedDescription != nil ) {
            errorString = localizedDescription;
        }
        
        if ( [userInfo objectForKey:@"Invalid param"]) {
            errorString = [userInfo objectForKey:@"Invalid param"];
        }
    }
    
    return errorString;
}

#pragma mark - Present New Controller
-(void)presentQRScan
{

    
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
    style.photoframeLineW = 6;
    style.photoframeAngleW = 24;
    style.photoframeAngleH = 24;
    style.isNeedShowRetangle = YES;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    
    UIImage *imgPartNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_part_net"];
    
    style.animationImage = imgPartNet;

    QRScanViewController *qRScanViewController = [QRScanViewController new];
    qRScanViewController.style = style;
    //qRScanViewController.isOpenInterestRect = YES;
    BaseNavigationController *baseNavigationController = [[BaseNavigationController alloc] initWithRootViewController:qRScanViewController];
    baseNavigationController.isStatusBarLight = YES;
    [self presentViewController:baseNavigationController animated:YES completion:^{
        
    }];
}

#pragma mark - Navigation Controller
- (UIViewController *)backViewController
{
    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    
    if (numberOfViewControllers < 2)
        return nil;
    else
        return [self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 2];
}

#pragma mark - Tabbar
-(void)expandTabBar
{
    if( _hideTabBar )
        return;
    
    _hideTabBar = YES;
    
    [self.tabBarController setTabBarHidden:YES
                                  animated:YES];
}

-(void)contractTabBar
{
    if( !_hideTabBar )
        return;
    
    _hideTabBar = NO;
    
    [self.tabBarController setTabBarHidden:NO
                                  animated:YES];
}

- (void)tabBarAnimateHideShow: (UIScrollView *)scrollView
{

    if( [scrollView.panGestureRecognizer translationInView:self.view].y  < 0.0f ) {
        
        [self expandTabBar];
    } else if ([scrollView.panGestureRecognizer translationInView:self.view].y  > 0.0f  ) {

        [self contractTabBar];
    }
}


-(void)setTabBarHidden: (BOOL)hidden withAnimated: (BOOL)animated
{
    _hideTabBar = hidden;
    
    [self.tabBarController setTabBarHidden:hidden
                                  animated:animated];
}

@end
