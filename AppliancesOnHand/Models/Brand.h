//
//  Brand.h
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/30/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brand : NSObject

@property (nonatomic) NSString *brandId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *varname;
@property (nonatomic) NSString *image;

+(instancetype)brandWithDatas: (NSDictionary *)datas;
-(instancetype)initWithDatas: (NSDictionary *)datas;
+(NSArray *) getTVBrandObjects;
+(NSArray *) getRadioBrandObjects;
+(NSArray *) getAirBrandObjects;

@end
