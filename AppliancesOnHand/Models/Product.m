//
//  Product.m
//  bike2day
//
//  Created by DEVTAB_006 on 1/4/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "Product.h"

@implementation Product

-(instancetype) init
{
    self = [self initWithDatas:nil];
    
    return self;
}

-(instancetype)initWithDatas:(NSDictionary *)datas
{
    
    
    self = [super init];
    
    if (self) {
        
        self.productId = [datas objectForKey:@"_id"] != nil  ? [datas objectForKey:@"_id"] : @"";
        self.name = [datas objectForKey:@"name"] != nil  ? [datas objectForKey:@"name"] : @"";
        self.desc = [datas objectForKey:@"description"] != nil  ? [datas objectForKey:@"description"] : @"";
        self.details = [datas objectForKey:@"details"] != nil  ? [datas objectForKey:@"details"] : @[];
        self.gender = [datas objectForKey:@"gender"] != nil  ? [datas objectForKey:@"gender"] : @"";
        self.price = [datas objectForKey:@"price"] != nil  ? [[datas objectForKey:@"price"] integerValue] : 0;
        self.fee = [datas objectForKey:@"fee"] != nil  ? [[datas objectForKey:@"fee"] doubleValue] : 0;
        self.size = [datas objectForKey:@"size"] != nil  ? [datas objectForKey:@"size"] : @"";
        self.sku = [datas objectForKey:@"sku"] != nil  ? [datas objectForKey:@"sku"] : @"";
        self.pictures = [datas objectForKey:@"pictures"] != nil  ? [datas objectForKey:@"pictures"] : @[];
        self.picture = [datas objectForKey:@"picture"] != nil  ? [datas objectForKey:@"picture"] : @"";
        
        NSDictionary *shipping = [datas objectForKey:@"shipping"];
        
        if ( shipping != nil ) {
            self.shippingPrice = [shipping objectForKey:@"price"] != nil  ? [[shipping objectForKey:@"price"] integerValue] : 0;
        }
        else
        {
            self.shippingPrice = 0;
        }
        
    }
    
    return self;
}

+(instancetype)productWithDatas:(NSDictionary *)datas
{
    return [[[self class] alloc] initWithDatas:datas];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self) {
        self.productId = [aDecoder decodeObjectForKey:@"id"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.desc = [aDecoder decodeObjectForKey:@"email"];
        self.details = [aDecoder decodeObjectForKey:@"details"];
        self.gender = [aDecoder decodeObjectForKey:@"picture"];
        self.price = [aDecoder decodeIntegerForKey:@"price"];
        self.size = [aDecoder decodeObjectForKey:@"size"];
        self.sku = [aDecoder decodeObjectForKey:@"sku"];
        self.pictures = [aDecoder decodeObjectForKey:@"pictures"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.productId forKey:@"id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.details forKey:@"details"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeInteger:self.price forKey:@"price"];
    [aCoder encodeObject:self.size forKey:@"size"];
    [aCoder encodeObject:self.sku forKey:@"sku"];
    [aCoder encodeObject:self.pictures forKey:@"pictures"];
}

+(Product *)getObjectWithId:(NSString *)productId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *getArchivedObject = [defaults objectForKey:@"products"];
    NSDictionary *objects = (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:getArchivedObject];
    
    Product *product = [objects objectForKey:productId];
    return product;
}

+(void)saveObject:(Product *)object withId:(NSString *)productId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *getArchivedObject = [defaults objectForKey:@"products"];
    NSDictionary *objects = (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:getArchivedObject];
    
    NSMutableDictionary *mutaObjects = [[NSMutableDictionary alloc] init];
    if ( objects ) {
        [mutaObjects addEntriesFromDictionary:objects];
    }
    [mutaObjects setObject:object forKey:productId];
    
    NSData *saveArchivedObject = [NSKeyedArchiver archivedDataWithRootObject:mutaObjects];
    [defaults setObject:saveArchivedObject forKey:@"products"];
    [defaults synchronize];
}

@end
