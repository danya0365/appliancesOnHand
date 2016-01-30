//
//  Product.h
//  bike2day
//
//  Created by DEVTAB_006 on 1/4/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject <NSCoding>

@property (nonatomic) NSString *productId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *desc;
@property (nonatomic) NSArray *details;
@property (nonatomic) NSString *gender;
@property (nonatomic) NSArray *pictures;
@property (nonatomic) NSString *picture;
@property (nonatomic) NSUInteger price;
@property (nonatomic) double fee;
@property (nonatomic) NSString *size;
@property (nonatomic) NSString *sku;
@property (nonatomic) NSUInteger shippingPrice;

+(instancetype)productWithDatas: (NSDictionary *)datas;
-(instancetype)initWithDatas: (NSDictionary *)datas;
+(Product *)getObjectWithId: (NSString *)productId;
+(void)saveObject: (Product *) object withId: (NSString *)productId;

@end
