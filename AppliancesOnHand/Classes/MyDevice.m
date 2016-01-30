//
//  MyDevice.m
//  mam
//
//  Created by DEVTAB_006 on 11/29/2558 BE.
//  Copyright © 2558 DEVTAB_006. All rights reserved.
//

#import "MyDevice.h"
#import <sys/utsname.h>
#import <iAppInfos/iAppInfos.h>

@implementation MyDevice

+ (NSString *)deviceModelName{

    return [[iAppInfos sharedInfo] deviceModelName];
}

+ (NSString *)deviceOperator{
    
    return [[iAppInfos sharedInfo] operatorName];
}


+(NSString *)deviceEnvironment
{
    NSString *environment = @"development";
    NSDictionary *mobileProvisionning = [iAppInfos sharedInfo].mobileProvisionning.summary;
    environment = [mobileProvisionning objectForKey:@"Push Enable (PROD)"] != nil ? @"production" : @"development";
    return environment;
}


@end
