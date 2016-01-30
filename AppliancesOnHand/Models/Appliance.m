//
//  Appliance.m
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/26/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "Appliance.h"

@implementation Appliance

-(instancetype) init
{
    self = [self initWithDatas:nil];
    
    return self;
}

-(instancetype)initWithDatas:(NSDictionary *)datas
{
    self = [super init];
    
    if (self) {

        self.applianceId = [datas objectForKey:@"id"] != nil  ? [datas objectForKey:@"id"] : @"";
        self.name = [datas objectForKey:@"name"] != nil  ? [datas objectForKey:@"name"] : @"";
        self.varname = [datas objectForKey:@"varname"] != nil  ? [datas objectForKey:@"varname"] : @"";
        self.image = [datas objectForKey:@"image"] != nil  ? [datas objectForKey:@"image"] : @"";
        
    }
    return self;
}

+(instancetype)applianceWithDatas:(NSDictionary *)datas
{
    return [[[self class] alloc] initWithDatas:datas];
}

+(NSArray *)getObjects
{
    NSArray *arrays = @[[[self class] applianceWithDatas:@{@"id": @"1", @"name": NSLocalizedString(@"television_name", nil),@"image": @"television-03-icon", @"varname" : @"tv"}], [[self class] applianceWithDatas:@{@"id": @"1", @"name": NSLocalizedString(@"radio_name", nil), @"image": @"radio-icon-02" , @"varname" : @"radio"}], [[self class] applianceWithDatas:@{@"id": @"1", @"name": NSLocalizedString(@"air_conditioner_name", nil), @"image" : @"air-conditioner-icon.jpeg", @"varname" : @"air"}]];
    
    return arrays;
}

@end
