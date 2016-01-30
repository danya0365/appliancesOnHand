//
//  Brand.m
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/30/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "Brand.h"

@implementation Brand

-(instancetype) init
{
    self = [self initWithDatas:nil];
    
    return self;
}

-(instancetype)initWithDatas:(NSDictionary *)datas
{
    self = [super init];
    
    if (self) {
        
        self.brandId = [datas objectForKey:@"id"] != nil  ? [datas objectForKey:@"id"] : @"";
        self.name = [datas objectForKey:@"name"] != nil  ? [datas objectForKey:@"name"] : @"";
        self.varname = [datas objectForKey:@"varname"] != nil  ? [datas objectForKey:@"varname"] : @"";
        self.image = [datas objectForKey:@"image"] != nil  ? [datas objectForKey:@"image"] : @"";
        
    }
    return self;
}

+(instancetype)brandWithDatas:(NSDictionary *)datas
{
    return [[[self class] alloc] initWithDatas:datas];
}

+(NSArray *)getTVBrandObjects
{
    NSArray *arrays = @[[[self class] brandWithDatas:@{@"id": @"1", @"name": NSLocalizedString(@"lg", nil),@"image": @"", @"varname" : @"lg"}], [[self class] brandWithDatas:@{@"id": @"1", @"name": NSLocalizedString(@"sony", nil), @"image": @"" , @"varname" : @"sony"}], [[self class] brandWithDatas:@{@"id": @"1", @"name": NSLocalizedString(@"samsung", nil), @"image" : @"", @"varname" : @"samsung"}]];
    
    return arrays;
}

+(NSArray *)getAirBrandObjects
{
    NSArray *arrays = @[[[self class] brandWithDatas:@{@"id": @"1", @"name": NSLocalizedString(@"lg", nil),@"image": @"", @"varname" : @"lg"}], [[self class] brandWithDatas:@{@"id": @"1", @"name": NSLocalizedString(@"sony", nil), @"image": @"" , @"varname" : @"sony"}], [[self class] brandWithDatas:@{@"id": @"1", @"name": NSLocalizedString(@"samsung", nil), @"image" : @"", @"varname" : @"samsung"}]];
    
    return arrays;
}

+(NSArray *)getRadioBrandObjects
{
    NSArray *arrays = @[[[self class] brandWithDatas:@{@"id": @"1", @"name": NSLocalizedString(@"lg", nil),@"image": @"", @"varname" : @"lg"}], [[self class] brandWithDatas:@{@"id": @"1", @"name": NSLocalizedString(@"sony", nil), @"image": @"" , @"varname" : @"sony"}], [[self class] brandWithDatas:@{@"id": @"1", @"name": NSLocalizedString(@"samsung", nil), @"image" : @"", @"varname" : @"samsung"}]];
    
    return arrays;
}


@end
