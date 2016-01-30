//
//  Remote.m
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/30/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "Remote.h"

@implementation Remote
{
    NSTimer *timer;
    NSUInteger minChannel;
    NSUInteger maxChannel;
    NSUInteger minVolumn;
    NSUInteger maxVolumn;
    
    RemoteSource _connectionSource;
    RemoteConnectionState _connectionState;
    NSUInteger _currentVolumn;
    NSUInteger _currentChannel;
    NSUInteger _connectedDuration;
    BOOL _isMute;
    BOOL _isDeviceTurnOn;
}

-(instancetype) init
{
    self = [super init];
    
    if ( self) {
        
        _isDeviceTurnOn = NO;
        _isMute = NO;
        _currentChannel = 1;
        _currentVolumn = 16;
        _connectionSource = RemoteSourceInternal;
        _connectionState = RemoteConnectionStateIdle;
        
        minChannel = 1;
        maxChannel = 99;
        minVolumn = 0;
        maxVolumn = 99;
    }
    return self;
}

-(void)startConnection
{
    if ( timer != nil ) {
        [self stopConnection];
    }
    
    _connectedDuration = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    
}

-(void)stopConnection
{
    if ( timer) {
        [timer invalidate];
        timer = nil;
    }
}

-(void)onTimer:(NSTimer *)timer {

    _connectedDuration += 1;
    
    NSUInteger tempDuration = _connectedDuration; //(_connectedDuration % 61);

    //NSLog(@"tempDuration: %lu", (unsigned long)tempDuration);
    
    
    if ( ! _isDeviceTurnOn ) {
        
        _connectedDuration = 0;
        //self.connectionState = RemoteConnectionStateIdle;
        
        [self setConnectionState:RemoteConnectionStateIdle];
        //NSLog(@"Device turn off");
        return;
    }
    
    if ( tempDuration == 1 ) {
        //self.connectionState = RemoteConnectionStateConnecting;
        [self setConnectionState:RemoteConnectionStateConnecting];
    }
    
    
    if ( tempDuration == 5 ) {
        //self.connectionState = RemoteConnectionStateConnected;
        [self setConnectionState:RemoteConnectionStateConnected];
    }
    
    
    if ( tempDuration == 60 ) {
        //self.connectionState = RemoteConnectionStateDisconnected;
        [self setConnectionState:RemoteConnectionStateDisconnected];
    }
}

-(void)setConnectionState:(RemoteConnectionState)connectionState
{
    /*
    if ( _connectionState != RemoteConnectionStateConnected ) {
        if ( [_delegate respondsToSelector:@selector(remote:onError:)]) {
            [_delegate remote:self onError:@"Remote not connected"];
        }
        return;
    }
    */
    
    _connectionState = connectionState;
    
    if ( [_delegate respondsToSelector:@selector(remote:connectionChangeToState:)]) {
        [_delegate remote:self connectionChangeToState:connectionState];
    }
}

-(void)setCurrentChannel:(NSUInteger)currentChannel
{
    

    
    if ( !_isDeviceTurnOn ) {
        if ( [_delegate respondsToSelector:@selector(remote:onError:)]) {
            [_delegate remote:self onError:@"Device is turn off"];
        }
        return;
    }
    
    if ( _connectionState != RemoteConnectionStateConnected ) {
        if ( [_delegate respondsToSelector:@selector(remote:onError:)]) {
            [_delegate remote:self onError:@"Remote not connected"];
        }
        return;
    }
    
    if ( _connectionSource != RemoteSourceInternal ) {
        if ( [_delegate respondsToSelector:@selector(remote:onError:)]) {
            [_delegate remote:self onError:@"This Function work only on Internal Source"];
        }
        return;
    }
    
    if ( currentChannel < minChannel || currentChannel > maxChannel ) {
        
        if ( [_delegate respondsToSelector:@selector(remote:onError:)]) {
            [_delegate remote:self onError:[NSString stringWithFormat:@"Channel out of range, system work between: %lu and %lu", (unsigned long)minChannel, maxChannel]];
        }
        return;
    }
    
    _currentChannel = currentChannel;
    
    NSLog(@"Channel Change to: %lu", _currentChannel);
    
    if ([_delegate respondsToSelector:@selector(remote:onChannelChange:)]) {
        [_delegate remote:self onChannelChange:_currentChannel];
    }
}

-(void)setCurrentVolumn:(NSUInteger)currentVolumn
{
    
    if ( !_isDeviceTurnOn ) {
        if ( [_delegate respondsToSelector:@selector(remote:onError:)]) {
            [_delegate remote:self onError:@"Device is turn off"];
        }
        return;
    }
    
    if ( _connectionState != RemoteConnectionStateConnected ) {
        if ( [_delegate respondsToSelector:@selector(remote:onError:)]) {
            [_delegate remote:self onError:@"Remote not connected"];
        }
        return;
    }
    
    
    if ( currentVolumn < minVolumn || currentVolumn > maxVolumn ) {
        
        if ( [_delegate respondsToSelector:@selector(remote:onError:)]) {
            [_delegate remote:self onError:[NSString stringWithFormat:@"Volumn out of range, system work between: %lu and %lu", (unsigned long)minChannel, maxChannel]];
        }
        return;
    }
    
    _currentVolumn = currentVolumn;
    
    
    NSLog(@"Volumn Change to: %lu", _currentVolumn);
    
    if ([_delegate respondsToSelector:@selector(remote:onVolumnChange:)]) {
        [_delegate remote:self onVolumnChange:_currentVolumn];
    }
}

-(void)changeNextSource
{
    

    
    if ( !_isDeviceTurnOn ) {
        if ( [_delegate respondsToSelector:@selector(remote:onError:)]) {
            [_delegate remote:self onError:@"Device is turn off"];
        }
        return;
    }
    
    if ( _connectionState != RemoteConnectionStateConnected ) {
        if ( [_delegate respondsToSelector:@selector(remote:onError:)]) {
            [_delegate remote:self onError:@"Remote not connected"];
        }
        return;
    }
    
    RemoteSource remoteSource = _connectionSource + 1;
    
    if ( remoteSource > RemoteSourceHDMI) {
        remoteSource = RemoteSourceInternal;
    }
    
    [self setConnectionSource:remoteSource];
}

-(void)setConnectionSource:(RemoteSource)connectionSource
{
    

    
    if ( !_isDeviceTurnOn ) {
        if ( [_delegate respondsToSelector:@selector(remote:onError:)]) {
            [_delegate remote:self onError:@"Device is turn off"];
        }
        return;
    }
    
    if ( _connectionState != RemoteConnectionStateConnected ) {
        if ( [_delegate respondsToSelector:@selector(remote:onError:)]) {
            [_delegate remote:self onError:@"Remote not connected"];
        }
        return;
    }
    
    _connectionSource = connectionSource;
    
    if ( [_delegate respondsToSelector:@selector(remote:connectionChangeToSource:)]) {
        [_delegate remote:self connectionChangeToSource:_connectionSource];
    }
}

-(void)setIsDeviceTurnOn:(BOOL)isOn
{
    _isDeviceTurnOn = isOn;
    //self.isDeviceTurnOn = _isDeviceTurnOn;
}

-(void)setIsMute:(BOOL)isMute
{
    
    if ( !_isDeviceTurnOn ) {
        if ( [_delegate respondsToSelector:@selector(remote:onError:)]) {
            [_delegate remote:self onError:@"Device is turn off"];
        }
        return;
    }
    
    if ( _connectionState != RemoteConnectionStateConnected ) {
        if ( [_delegate respondsToSelector:@selector(remote:onError:)]) {
            [_delegate remote:self onError:@"Remote not connected"];
        }
        return;
    }
    
    _isMute = isMute;
    //self.isMute = _isMute;
}

             
@end
