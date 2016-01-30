//
//  Appliance.h
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/26/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Appliance : NSObject

@property (nonatomic) NSString *applianceId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *varname;
@property (nonatomic) NSString *image;

+(instancetype)applianceWithDatas: (NSDictionary *)datas;
-(instancetype)initWithDatas: (NSDictionary *)datas;
+(NSArray *) getObjects;

@end
