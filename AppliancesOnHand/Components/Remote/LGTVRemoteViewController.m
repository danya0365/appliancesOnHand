//
//  LGTVRemoteViewController.m
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/30/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "LGTVRemoteViewController.h"
#import "Remote.h"
#import "TVModel.h"
#import "Brand.h"

@interface LGTVRemoteViewController () <RemoteDelegate>

@property (nonatomic, strong) Remote *remote;

@end

@implementation LGTVRemoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupView];
    [self setupRemote];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self updateContentSize];
}

#pragma mark - setup view

-(void)setupView
{
    self.title = [NSString stringWithFormat:@"Remote: %@ - %@", self.tvModel.brand.name, self.tvModel.name];
    //self.contentView.layer.cornerRadius = 10.0f;
    //self.contentView.layer.masksToBounds = YES;
    self.monitorLCDViewWrapperHeight.constant = 0.0f;
    [self.contentScrollView layoutIfNeeded];
    
    [self setLCDMonitorWithShow:NO];
}

-(void)setLCDMonitorWithShow: (BOOL)isShow
{
    if ( isShow) {
        self.monitorLCDViewWrapperHeight.constant = 200.0f;
        [self.contentScrollView layoutIfNeeded];
    }
    else
    {
        self.monitorLCDViewWrapperHeight.constant = 0.0f;
        [self.contentScrollView layoutIfNeeded];
    }
}


-(void)updateScrollViewContentSize
{
    self.contentScrollView.contentSize = CGSizeMake(self.contentView.frame.size.width, self.contentView.frame.size.height);
}

-(void)updateContentSize
{
    CGFloat viewWidth = self.view.frame.size.width;
    
    if ( viewWidth > 600 ) {
        viewWidth = 600;
    }
    else
    {
        viewWidth -= 16;
    }
    
    self.contentViewWidth.constant = viewWidth;
    [self.contentScrollView layoutIfNeeded];

    [self updateScrollViewContentSize];
}

-(void)changeStatusMessage: (RemoteConnectionState )connectionState
{
    NSString *message = @"-";
    switch (connectionState) {
        case RemoteConnectionStateConnecting:
            message = @"Connecting...";
            break;
        case RemoteConnectionStateConnected:
            message = @"Connected";
            break;
        case RemoteConnectionStateDisconnected:
            message = @"Disconnected!";
            
            [self performSelector:@selector(autoConnect) withObject:nil afterDelay:3.0f];
            break;
        case RemoteConnectionStateIdle:
            message = @"Idle";
            break;
            
        default:
            break;
    }
    
    self.statusMessage.text = message;
    
    [self changeLCDTextMessage];
}

-(void)changeLCDTextMessage
{
    if ( self.remote.isDeviceTurnOn) {
        
        if ( self.remote.connectionState == RemoteConnectionStateConnected) {
            
            self.lcdTextDemoOnlyLabel.text = [NSString stringWithFormat:NSLocalizedString(@"lcd_viewing_x_channel_mesage", nil), [NSNumber numberWithInteger:self.remote.currentChannel]];
        }
        else
        {
            self.lcdTextDemoOnlyLabel.text = [NSString stringWithFormat:NSLocalizedString(@"lcd_viewing_turn_off_mesage", nil)];
        }
    }
    else
    {
        self.lcdTextDemoOnlyLabel.text = [NSString stringWithFormat:NSLocalizedString(@"lcd_viewing_turn_off_mesage", nil)];
    }
}

-(void)changeChannelMessage: (NSUInteger )channel
{
    self.channelMessage.text = [NSString stringWithFormat:NSLocalizedString(@"channel_mesage", nil), [NSNumber numberWithInteger:channel]];
    
    [self changeLCDTextMessage];
}

-(void)changeVolumnMessage: (NSUInteger )volumn
{
    self.volumnMessage.text = [NSString stringWithFormat:NSLocalizedString(@"volumn_mesage", nil), [NSNumber numberWithInteger:volumn]];
}

-(void)changeSourceMessage: (RemoteSource )source
{
    
    NSString *soureName = @"-";
    
    switch (source) {
        case RemoteSourceInternal:
            soureName = NSLocalizedString(@"source_antenna", nil);
            break;
        case RemoteSourceAV:
            soureName = NSLocalizedString(@"source_av", nil);
            break;
        case RemoteSourceComponent:
            soureName = NSLocalizedString(@"source_component", nil);
            break;
        case RemoteSourceHDMI:
            soureName = NSLocalizedString(@"source_hdmi", nil);
            break;
            
        default:
            break;
    }
    self.sourceMessage.text = [NSString stringWithFormat:NSLocalizedString(@"source_mesage", nil), soureName];
}


#pragma mark - Remote
-(void) setupRemote
{
    _remote = [[Remote alloc] init];
    _remote.delegate = self;
    [_remote startConnection];
    
    [self changeStatusMessage:_remote.connectionState];
    [self changeSourceMessage:_remote.connectionSource];
    [self changeChannelMessage:_remote.currentChannel];
    [self changeVolumnMessage:_remote.currentVolumn];
    
}

-(void)autoConnect
{
    self.statusMessage.text = @"Trying to connect...";
    
    [self.remote performSelector:@selector(startConnection) withObject:nil afterDelay:2.0f];
}

#pragma mark - Remote Delegate
-(void)remote:(Remote *)remote connectionChangeToState:(RemoteConnectionState)connectionState
{
    
    [self changeStatusMessage:connectionState];
}

-(void)remote:(Remote *)remote connectionChangeToSource:(RemoteSource)connectSource
{
    
    [self changeSourceMessage:connectSource];
}

-(void)remote:(Remote *)remote onChannelChange:(NSUInteger)channelNumber
{
    
    [self changeChannelMessage:channelNumber];
}

-(void)remote:(Remote *)remote onVolumnChange:(NSUInteger)volumnNumber
{
    
    [self changeVolumnMessage:volumnNumber];
}

-(void)remote:(Remote *)remote onError:(NSString *)errorMessage
{
    
    //[self presentErrorToastAnimationDirectionTopWithMessage:errorMessage];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Dismiss"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];

    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}



#pragma mark - Button Action
- (IBAction)onOffMenuToggleAction:(id)sender {
    
    [self presentInfoToastAnimationDirectionTopWithMessage:@"Menu button click"];
}

- (IBAction)changeSourceAction:(id)sender {
    
    [self.remote changeNextSource];
}

- (IBAction)onOffToggleAction:(id)sender {
    
    _onOffButton.selected = !_onOffButton.selected;

    [self.remote setIsDeviceTurnOn:_onOffButton.selected];
    
    [self changeLCDTextMessage];
}

- (IBAction)onOffLCDToggleAction:(id)sender {
    
    _onOffLCDButton.selected = !_onOffLCDButton.selected;
    
    [self setLCDMonitorWithShow:_onOffLCDButton.selected];
}

- (IBAction)menuNavigateTop:(id)sender {
    
    NSUInteger nextChannel = self.remote.currentChannel + 1;
    [self.remote setCurrentChannel:nextChannel];
}

- (IBAction)menuNavigateRight:(id)sender {

    NSUInteger nextVolumn = self.remote.currentVolumn + 1;
    [self.remote setCurrentVolumn:nextVolumn];
}

- (IBAction)menuNavigateBottom:(id)sender {
    NSUInteger nextChannel = self.remote.currentChannel - 1;
    [self.remote setCurrentChannel:nextChannel];
}

- (IBAction)menuNavigateLeft:(id)sender {
    
    NSUInteger nextVolumn = self.remote.currentVolumn - 1;
    [self.remote setCurrentVolumn:nextVolumn];
}

- (IBAction)menuExitAction:(id)sender {
    
    [self presentInfoToastAnimationDirectionTopWithMessage:@"Exit button click"];
}

- (IBAction)menuCancelAction:(id)sender {

    [self presentInfoToastAnimationDirectionTopWithMessage:@"Cancel button click"];
}

- (IBAction)menuMuteAction:(id)sender {
    
    self.muteButton.selected = !self.muteButton.selected;
    [self.remote setIsMute:self.muteButton.selected];
}

- (IBAction)menuOKAction:(id)sender {

    [self presentInfoToastAnimationDirectionTopWithMessage:@"OK button click"];
}

@end
