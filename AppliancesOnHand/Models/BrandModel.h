//
//  BrandModel.h
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/30/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Brand;

@interface BrandModel : NSObject

@property (nonatomic) Brand *brand;

@property (nonatomic) NSString *modelId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *varname;
@property (nonatomic) NSString *image;

+(instancetype)brandModelWithDatas: (NSDictionary *)datas brand: (Brand *)brand;
-(instancetype)initWithDatas: (NSDictionary *)datas brand: (Brand *)brand;

@end
