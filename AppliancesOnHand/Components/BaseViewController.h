//
//  BaseViewController.h
//  mam
//
//  Created by DEVTAB_006 on 11/18/2558 BE.
//  Copyright © 2558 DEVTAB_006. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController

@property (nonatomic, assign) CGRect bounds;
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, assign) NSUInteger tableDataLimit;
@property (nonatomic, assign) NSUInteger tableDataOffset;
@property (nonatomic, assign) NSUInteger tableDataMax;
@property (nonatomic, assign) BOOL tableCanLoadMore;
@property (nonatomic, assign) BOOL tableLoadingMore;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSNumberFormatter *formatterCurrency;
@property (strong, nonatomic) NSNumberFormatter *numberFormatter;

+(instancetype)defaultNib;
+(instancetype)loadWithNib: (NSString *)nibName;
- (void) loadViewFromInit;
- (void) contentSizeDidChange:(NSString*)size;
- (void) setNavigationBarTransparent;
- (void) setNavigationBarBackground;
- (void) setTransclucentView;
- (void) setDisableTransclucentView;
- (void) refreshTableView;
- (void) refreshCollectionView;
- (BOOL) isConnected;
- (void) addRefreshControlToTableView: (UITableView *)tableView;
- (void) addRefreshControlToCollectionView: (UICollectionView *)collectionVIew;
- (void) presentSuccessToastAnimationDirectionTopWithMessage: (NSString *)message;
- (void) presentInfoToastAnimationDirectionTopWithMessage: (NSString *)message;
- (void) presentAttentionToastAnimationDirectionTopWithMessage: (NSString *)message;
- (void) presentErrorToastAnimationDirectionTopWithMessage: (NSString *)message;
- (void) setBarBackButton;
- (void) setBarCloseButton;
- (void) showActivityIndicator;
- (void) hideActivityIndicator;
- (void) presentQRScan;
- (UIViewController *) backViewController;
- (NSString *) getErrorMessage:(NSError *) error;
- (void) tabBarAnimateHideShow: (UIScrollView *)scrollView;
- (void) setTabBarHidden: (BOOL)hidden withAnimated: (BOOL)animated;
- (CGSize )getViewSize: (id )view;
- (void) hideKeyboard;

@end
