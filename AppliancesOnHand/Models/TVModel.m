//
//  TVModel.m
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/30/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "TVModel.h"
#import "Brand.h"

@implementation TVModel

+(NSArray *)getLGTVModelObjects
{
    Brand *lgBrand = nil;
    for (Brand *brand in [Brand getTVBrandObjects]) {
        
        if ( [brand.varname isEqualToString:@"lg"] ) {
            lgBrand = brand;
        }
    }
    
    NSAssert(lgBrand != nil, @"lgBrand can not be nil");
    
    NSArray *arrays = @[[[self class] brandModelWithDatas:@{@"id": @"1", @"name": @"UC9T",@"image": @"", @"varname" : @"UC9T"} brand:lgBrand], [[self class] brandModelWithDatas:@{@"id": @"1", @"name": @"EC930T", @"image": @"" , @"varname" : @"EC930T"}  brand:lgBrand], [[self class] brandModelWithDatas:@{@"id": @"1", @"name": @"LF595D", @"image" : @"", @"varname" : @"LF595D"}  brand:lgBrand]];
    
    return arrays;
}

@end
