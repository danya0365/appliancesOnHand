//
//  BrandModel.m
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/30/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "BrandModel.h"

@implementation BrandModel

-(instancetype) init
{
    self = [self initWithDatas:nil brand:nil];
    
    return self;
}

-(instancetype)initWithDatas:(NSDictionary *)datas brand:(Brand *)brand
{
    self = [super init];
    
    if (self) {
        
        self.modelId = [datas objectForKey:@"id"] != nil  ? [datas objectForKey:@"id"] : @"";
        self.name = [datas objectForKey:@"name"] != nil  ? [datas objectForKey:@"name"] : @"";
        self.varname = [datas objectForKey:@"varname"] != nil  ? [datas objectForKey:@"varname"] : @"";
        self.image = [datas objectForKey:@"image"] != nil  ? [datas objectForKey:@"image"] : @"";
        
        self.brand = brand;
        
    }
    return self;
}

+(instancetype)brandModelWithDatas:(NSDictionary *)datas brand:(Brand *)brand
{
    return [[[self class] alloc] initWithDatas:datas brand:brand];
}

@end
