//
//  DevtabPageController.h
//  bike2day
//
//  Created by DEVTAB_006 on 1/19/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "define.h"

typedef NS_ENUM(NSInteger, DevtabPageMode) {
    Devtab_FreeButtons,
    Devtab_LeftRightArrows,
    Devtab_SegmentController
};

@class DevtabPageController;

@protocol DevtabPageControllerDataSource <NSObject>
@required
- (NSArray *) DevtabPageButtons;
- (NSArray *) DevtabPageControllers;
- (UIView *) DevtabPageContainer;
@end

@protocol DevtabPageControllerDelegate <NSObject>

@optional
-(BOOL)devtabPageController:(DevtabPageController *)viewController shouldSwitchAtIndex: (NSUInteger )index;
- (void)devtabPageChangedToIndex:(NSInteger)index;
@end

@interface DevtabPageController : UIPageViewController  <UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate>


@property (nonatomic, weak) id<DevtabPageControllerDelegate> devtabDelegate;
@property (nonatomic, weak) id<DevtabPageControllerDataSource> devtabDataSource;


@property (nonatomic, strong) NSMutableArray *viewControllerArray;
@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UIScrollView *scrollNavigationView;
@property (nonatomic, assign) NSInteger buttonPressed;

@property (nonatomic, strong) UIScrollView *pageScrollView;
@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, strong) NSArray *connectedButtons;

@property (nonatomic, assign) DevtabPageMode pageMode;     // This selects the mode of the PageViewController

- (void)reloadPages;                                // Like reloadData in tableView. You need to call this method to update the stack of viewcontrollers and/or buttons
- (void)moveToViewNumber:(NSInteger)viewNumber;     // The ViewController position. Starts from 0

@end
