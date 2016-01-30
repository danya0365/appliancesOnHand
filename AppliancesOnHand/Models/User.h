//
//  User.h
//  bike2day
//
//  Created by DEVTAB_006 on 12/30/2558 BE.
//  Copyright © 2558 DEVTAB_006. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>

@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *facebookId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *gender;
@property (nonatomic) NSString *picture;
@property (nonatomic) NSString *facebookToken;
@property (nonatomic) NSString *userAccessToken;
@property (nonatomic) NSString *telephone;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *subDistrict;
@property (nonatomic) NSString *district;
@property (nonatomic) NSString *province;
@property (nonatomic) NSString *postalCode;

+(instancetype)userWithDatas: (NSDictionary *)datas;
-(instancetype)initWithDatas: (NSDictionary *)datas;
+(User *)getObject;
+(void)saveObject: (User *) object;
+(User *)getObjectForUpdate;
+(void)saveObjectForUpdate: (User *) object;
@end
