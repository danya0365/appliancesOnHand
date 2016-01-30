//
//  DevtabPageController.m
//  bike2day
//
//  Created by DEVTAB_006 on 1/19/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//


#import "DevtabPageController.h"

@interface DevtabPageController ()


@end

@implementation DevtabPageController


#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [[[self class] alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                            navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                          options:nil];
    
    if (self) {
        
        _viewControllerArray = [[NSMutableArray alloc] init];
        _currentPageIndex = 0;
        
        _pageMode = Devtab_FreeButtons;
    }
    return self;
}

#pragma mark - Public

- (void)reloadPages
{
    // Initialize/ Refresh everything
    [self loadControllerAndView];
    [self loadControllers];
    [self connectButtons];
}

- (void)moveToViewNumber:(NSInteger)viewNumber
{
    
    if ( [_devtabDelegate respondsToSelector:@selector(devtabPageController:shouldSwitchAtIndex:)]) {
        
        if ( ![_devtabDelegate devtabPageController:self shouldSwitchAtIndex:viewNumber]) {
            return;
        }
    }
    
    NSAssert([_viewControllerArray count] > viewNumber, @"viewNumber exceeds the number of current viewcontrollers");
    id viewController = _viewControllerArray[viewNumber];
    [self MBXPageChangedToIndex:_currentPageIndex];
    
    __weak __typeof(self)weakSelf = self;
    [self setViewControllers:@[viewController]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:^(BOOL finished) {
                      
                      if (!weakSelf) return;
                      __strong __typeof(weakSelf)strongSelf = weakSelf;
                      
                      dispatch_async(dispatch_get_main_queue(), ^{
                          
                          [strongSelf updateCurrentPageIndex:viewNumber];
                          [strongSelf setViewControllers:@[viewController]
                                               direction:UIPageViewControllerNavigationDirectionForward
                                                animated:NO completion:nil];
                      });
                  }];
    
}

#pragma mark - Setup

- (void)loadControllerAndView
{
    NSAssert([[self devtabDataSource] isKindOfClass:[UIViewController class]], @"This needs to be implemented in a class that inherits from UIViewController");
    [(UIViewController *)[self devtabDataSource] addChildViewController:self];
    [[[self devtabDataSource] DevtabPageContainer] addSubview:self.view];
}

- (void)loadControllers
{
    [_viewControllerArray removeAllObjects];
    NSArray* controllers = [[self devtabDataSource] DevtabPageControllers];
    NSAssert(controllers, @"DevtabPageControllers Array need to be non empty");
    [_viewControllerArray addObjectsFromArray:controllers];
    [self setupPageViewController];
}


- (void)connectButtons
{
    NSArray* buttons = [[self devtabDataSource] DevtabPageButtons];
    NSAssert([buttons count] > 0, @"Buttons needs to be at least 1");
    
    if (_pageMode == Devtab_SegmentController) {
        
        NSAssert([buttons count] == 1, @"Only one segmentcontroller can be used");
        NSAssert([[buttons objectAtIndex:0] isKindOfClass:[UISegmentedControl class]], @"The Object needs to be or inherit from UISegmentedControl");
        UISegmentedControl* segmentController = (UISegmentedControl*)[buttons objectAtIndex:0];
        NSAssert(segmentController.numberOfSegments == [_viewControllerArray count], @"The number of segments needs to be the same as the number of controllers");
        [segmentController addTarget:self
                              action:@selector(segmentControllerMode:)
                    forControlEvents:UIControlEventValueChanged];
        
        _connectedButtons = @[segmentController];
        return;
    }
    
    NSAssert(_viewControllerArray, @"addButtonsToSegmentPage Array need to be non empty");
    int i = 0;
    for (UIButton* button in buttons){
        NSAssert([button isKindOfClass:[UIButton class]], @"Add buttons to MBXPageButtons Array need to contain only UIButton elements");
        button.tag = i;
        
        switch (_pageMode) {
            case Devtab_FreeButtons:
                [button addTarget:self action:@selector(freeButtonsMode:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case Devtab_LeftRightArrows:
                [button addTarget:self action:@selector(leftRightMode:) forControlEvents:UIControlEventTouchUpInside];
                break;
            default:
                break;
        }
        i++;
    }
    _connectedButtons = buttons;
}


- (void)setupPageViewController
{
    NSAssert(_viewControllerArray, @"pageview controller need to have at last one controller");
    
    _pageController = self;
    
    _pageController.delegate = self;
    _pageController.dataSource = self;
    [_pageController setViewControllers:@[[_viewControllerArray objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self syncScrollView];
}

- (void)setupScrollNavigationController
{
    _scrollNavigationView.delegate = self;
}

-  (void)syncScrollView
{
    for (UIView* view in _pageController.view.subviews){
        if([view isKindOfClass:[UIScrollView class]])
        {
            _pageScrollView = (UIScrollView *)view;
            _pageScrollView.delegate = self;
        }
    }
}

- (void)viewWillLayoutSubviews
{
    UIView* container = [[self devtabDataSource] DevtabPageContainer];
    self.view.frame = CGRectMake(0.0, 0.0, container.frame.size.width, container.frame.size.height);
    [super viewWillLayoutSubviews];
}

#pragma mark -
#pragma mark - Button and Controller Interactions
#pragma mark - Free Buttons Mode

- (void)freeButtonsMode:(UIButton *)button
{
    NSInteger destination = button.tag;
    [self controllerModeLogicForDestination:destination];
}

#pragma mark - Left Right Buttons Mode

- (void)leftRightMode:(UIButton *)button
{
    NSInteger tempIndex = _currentPageIndex;
    __weak __typeof(&*self)weakSelf = self;
    // Check to see which way are you going (Left -> Right or Right -> Left)
    if (button.tag == 1) {
        
        if (!(tempIndex + 1 < [_viewControllerArray count])) {
            return;
        }
        
        NSInteger newIndex = tempIndex + 1;
        [self setPageControllerForIndex:newIndex direction:UIPageViewControllerNavigationDirectionForward currentMBXViewController:weakSelf];    }
    
    else if (button.tag == 0) {
        
        if (!(tempIndex > 0)) {
            return;
        }
        
        NSInteger newIndex = tempIndex - 1;
        [self setPageControllerForIndex:newIndex direction:UIPageViewControllerNavigationDirectionReverse currentMBXViewController:weakSelf];
    }
}

#pragma mark - Segment Controller Mode

- (void)segmentControllerMode:(UISegmentedControl *)segmentController
{
    // segmentController.numberOfSegments
    // segmentController.selectedSegmentIndex
    
    NSInteger destination = segmentController.selectedSegmentIndex;
    [self controllerModeLogicForDestination:destination];
}

- (void)updateSegmentControllerWithDestination:(NSInteger)destination
{
    UISegmentedControl *segmentController = (UISegmentedControl *)self.connectedButtons[0];
    [segmentController setSelectedSegmentIndex:destination];
}

#pragma mark - Controller Mode Common Logic

- (void)controllerModeLogicForDestination:(NSInteger)destination
{
    __weak __typeof(&*self)weakSelf = self;
    NSInteger tempIndex = _currentPageIndex;
    // Check to see which way are you going (Left -> Right or Right -> Left)
    if (destination > tempIndex) {
        for (int i = (int)tempIndex+1; i<=destination; i++) {
            [self setPageControllerForIndex:i direction:UIPageViewControllerNavigationDirectionForward currentMBXViewController:weakSelf destionation:destination];
        }
    }
    
    // Right -> Left
    else if (destination < tempIndex) {
        for (int i = (int)tempIndex-1; i >= destination; i--) {
            [self setPageControllerForIndex:i direction:UIPageViewControllerNavigationDirectionReverse currentMBXViewController:weakSelf destionation:destination];
        }
    }
}

- (void)setPageControllerForIndex:(NSInteger)index direction:(UIPageViewControllerNavigationDirection)direction currentMBXViewController:(id)weakSelf
{
    [self setPageControllerForIndex:index direction:direction currentMBXViewController:weakSelf destionation:0];
}

- (void)setPageControllerForIndex:(NSInteger)index direction:(UIPageViewControllerNavigationDirection)direction currentMBXViewController:(id)weakSelf destionation:(NSInteger)destination
{
    
    if ( [_devtabDelegate respondsToSelector:@selector(devtabPageController:shouldSwitchAtIndex:)]) {
        
        if ( ![_devtabDelegate devtabPageController:self shouldSwitchAtIndex:index]) {
            return;
        }
    }
    
    __block NSInteger pageModeBlock = _pageMode;
    [_pageController setViewControllers:@[[_viewControllerArray objectAtIndex:index]] direction:direction animated:YES completion:^(BOOL complete){
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        if (complete && strongSelf) {
            if ((pageModeBlock == Devtab_SegmentController) && (index != destination)) return; // It should update the segment buttons when the user already pressed in a segment
            [strongSelf updateCurrentPageIndex:index];
        }
    }];
}



- (void)updateCurrentPageIndex:(NSInteger)newIndex
{
    _currentPageIndex = newIndex;
    [self MBXPageChangedToIndex:_currentPageIndex];
}

// Delegate
- (void)MBXPageChangedToIndex:(NSInteger)index
{
    if ([self devtabDelegate]) {
        [[self devtabDelegate] devtabPageChangedToIndex:index];
    }
    
    if (_pageMode == Devtab_SegmentController) {
        [self updateSegmentControllerWithDestination:index];
    }
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfController:viewController];
    
    if ((index == NSNotFound) || (index == 0)) {
        return nil;
    }
    
    index--;
    return [_viewControllerArray objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfController:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    
    if (index == [_viewControllerArray count]) {
        return nil;
    }
    
    return [_viewControllerArray objectAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
    if (completed) {
        _currentPageIndex = [self indexOfController:[pageViewController.viewControllers lastObject]];
        [self MBXPageChangedToIndex:_currentPageIndex];
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers{
    _buttonPressed = -1;
}


- (NSInteger)indexOfController:(UIViewController *)viewController
{
    for (int i = 0; i < [_viewControllerArray count]; i++) {
        if (viewController == [_viewControllerArray objectAtIndex:i])
        {
            return i;
        }
    }
    return NSNotFound;
}

#pragma mark - Helpers

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@ description: %@", [super description], self.viewControllerArray];
}

@end
