//
//  LGTVRemoteViewController.h
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/30/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "BaseViewController.h"
@class TVModel;

@interface LGTVRemoteViewController : BaseViewController

@property (nonatomic) TVModel *tvModel;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;

@property (weak, nonatomic) IBOutlet UILabel *statusMessage;
@property (weak, nonatomic) IBOutlet UILabel *channelMessage;
@property (weak, nonatomic) IBOutlet UILabel *volumnMessage;
@property (weak, nonatomic) IBOutlet UILabel *sourceMessage;

@property (weak, nonatomic) IBOutlet UIView *monitorLCDViewWrapper;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *monitorLCDViewWrapperHeight;
@property (weak, nonatomic) IBOutlet UIView *monitorLCDView;

@property (weak, nonatomic) IBOutlet UILabel *lcdTextDemoOnlyLabel;

@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *onOffButton;
@property (weak, nonatomic) IBOutlet UIButton *onOffLCDButton;
@property (weak, nonatomic) IBOutlet UIButton *muteButton;


#pragma mark - Button Action
- (IBAction)onOffMenuToggleAction:(id)sender;
- (IBAction)changeSourceAction:(id)sender;
- (IBAction)onOffToggleAction:(id)sender;
- (IBAction)onOffLCDToggleAction:(id)sender;

- (IBAction)menuNavigateTop:(id)sender;
- (IBAction)menuNavigateRight:(id)sender;
- (IBAction)menuNavigateBottom:(id)sender;
- (IBAction)menuNavigateLeft:(id)sender;

- (IBAction)menuExitAction:(id)sender;
- (IBAction)menuCancelAction:(id)sender;
- (IBAction)menuMuteAction:(id)sender;
- (IBAction)menuOKAction:(id)sender;


@end
