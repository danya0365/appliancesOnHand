//
//  Remote.h
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/30/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    RemoteConnectionStateIdle,
    RemoteConnectionStateConnecting,
    RemoteConnectionStateConnected,
    RemoteConnectionStateDisconnected,
} RemoteConnectionState;

typedef enum : NSUInteger {
    RemoteSourceInternal,
    RemoteSourceAV,
    RemoteSourceComponent,
    RemoteSourceHDMI,
} RemoteSource;

@class Brand;
@class BrandModel;
@class Remote;

@protocol RemoteDelegate <NSObject>

@required;
-(void)remote: (Remote *)remote connectionChangeToState: (RemoteConnectionState)connectionState;
-(void)remote: (Remote *)remote connectionChangeToSource: (RemoteSource)connectSource;
-(void)remote: (Remote *)remote onError: (NSString *)errorMessage;
-(void)remote: (Remote *)remote onChannelChange: (NSUInteger )channelNumber;
-(void)remote: (Remote *)remote onVolumnChange: (NSUInteger )volumnNumber;

@end

@interface Remote : NSObject

@property (nonatomic, strong) id<RemoteDelegate> delegate;

@property (nonatomic, strong) Brand *brand;
@property (nonatomic, strong) BrandModel *brandModel;

@property (nonatomic, assign, readonly) RemoteConnectionState connectionState;
@property (nonatomic, assign, readonly) RemoteSource connectionSource;
@property (nonatomic, assign, readonly) NSUInteger currentVolumn;
@property (nonatomic, assign, readonly) NSUInteger currentChannel;
@property (nonatomic, assign, readonly) NSUInteger connectedDuration;
@property (nonatomic, assign, readonly) BOOL isMute;
@property (nonatomic, assign, readonly) BOOL isDeviceTurnOn;

-(void)startConnection;
-(void)stopConnection;
-(void)changeNextSource;

-(void)setIsDeviceTurnOn:(BOOL)isOn;
-(void)setCurrentChannel:(NSUInteger)currentChannel;
-(void)setCurrentVolumn:(NSUInteger)currentVolumn;
-(void)setIsMute:(BOOL)isMute;

@end
