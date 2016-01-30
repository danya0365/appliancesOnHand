//
//  User.m
//  bike2day
//
//  Created by DEVTAB_006 on 12/30/2558 BE.
//  Copyright © 2558 DEVTAB_006. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype) init
{
    self = [self initWithDatas:nil];
    
    return self;
}

-(instancetype)initWithDatas:(NSDictionary *)datas
{
    
    
    self = [super init];
    
    if (self) {
        
        if ( [datas objectForKey:@"name"] != nil ) {
            
            NSArray *fullNameArray = [[datas objectForKey:@"name"] componentsSeparatedByString:@" "];
            
            if ( [fullNameArray count] > 0) {
                
                if ( [fullNameArray count] >= 1 ) {
                    
                    if ( [datas objectForKey:@"first_name"] == nil ) {
                        
                        [datas setValue:[fullNameArray objectAtIndex:0] forKey:@"first_name"];
                    }
                }
                
                if ( [fullNameArray count] >= 2 ) {
                    if ( [datas objectForKey:@"last_name"] == nil ) {
                        
                        [datas setValue:[fullNameArray objectAtIndex:1] forKey:@"last_name"];
                    }
                }
                
            }
        }
        
        self.userId = [datas objectForKey:@"user_id"] != nil  ? [datas objectForKey:@"user_id"] : @"";
        self.facebookId = [datas objectForKey:@"facebook_id"] != nil  ? [datas objectForKey:@"facebook_id"] : @"";
        self.name = [datas objectForKey:@"name"] != nil  ? [datas objectForKey:@"name"] : @"";
        self.firstName = [datas objectForKey:@"first_name"] != nil  ? [datas objectForKey:@"first_name"] : @"";
        self.lastName = [datas objectForKey:@"last_name"] != nil  ? [datas objectForKey:@"last_name"] : @"";
        self.email = [datas objectForKey:@"email"] != nil  ? [datas objectForKey:@"email"] : @"";
        self.gender = [datas objectForKey:@"gender"] != nil  ? [datas objectForKey:@"gender"] : @"";
        self.userAccessToken = [datas objectForKey:@"user_access_token"] != nil  ? [datas objectForKey:@"user_access_token"] : @"";
        self.facebookToken = [datas objectForKey:@"facebook_token"] != nil  ? [datas objectForKey:@"facebook_token"] : @"";
        self.picture = [datas objectForKey:@"picture"] != nil  ? [datas objectForKey:@"picture"] : @"";
        self.telephone = [datas objectForKey:@"phone"] != nil  ? [datas objectForKey:@"phone"] : @"";
        
        self.address = [datas objectForKey:@"address"] != nil  ? [datas objectForKey:@"address"] : @"";
        self.subDistrict = [datas objectForKey:@"subDistrict"] != nil  ? [datas objectForKey:@"subDistrict"] : @"";
        self.district = [datas objectForKey:@"district"] != nil  ? [datas objectForKey:@"district"] : @"";
        self.province = [datas objectForKey:@"province"] != nil  ? [datas objectForKey:@"province"] : @"";
        self.postalCode = [datas objectForKey:@"postCode"] != nil  ? [datas objectForKey:@"postCode"] : @"";
        
        
        if ( [self.postalCode isKindOfClass:[NSNumber class]]) {
            self.postalCode = [NSString stringWithFormat:@"%@", self.postalCode];
        }
        
    }
    
    return self;
}

+(instancetype)userWithDatas:(NSDictionary *)datas
{
    return [[[self class] alloc] initWithDatas:datas];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self) {
        self.userId = [aDecoder decodeObjectForKey:@"user_id"];
        self.facebookId = [aDecoder decodeObjectForKey:@"facebook_id"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.firstName = [aDecoder decodeObjectForKey:@"first_name"];
        self.lastName = [aDecoder decodeObjectForKey:@"last_name"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.picture = [aDecoder decodeObjectForKey:@"picture"];
        self.userAccessToken = [aDecoder decodeObjectForKey:@"user_access_token"];
        self.facebookToken = [aDecoder decodeObjectForKey:@"facebook_token"];
        self.telephone = [aDecoder decodeObjectForKey:@"telephone"];
        
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.subDistrict = [aDecoder decodeObjectForKey:@"subDistrict"];
        self.district = [aDecoder decodeObjectForKey:@"district"];
        self.province = [aDecoder decodeObjectForKey:@"province"];
        self.postalCode = [aDecoder decodeObjectForKey:@"postalCode"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userId forKey:@"user_id"];
    [aCoder encodeObject:self.facebookId forKey:@"facebook_id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.firstName forKey:@"first_name"];
    [aCoder encodeObject:self.lastName forKey:@"last_name"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.picture forKey:@"picture"];
    [aCoder encodeObject:self.userAccessToken forKey:@"user_access_token"];
    [aCoder encodeObject:self.facebookToken forKey:@"facebook_token"];
    [aCoder encodeObject:self.telephone forKey:@"telephone"];
    
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.subDistrict forKey:@"subDistrict"];
    [aCoder encodeObject:self.district forKey:@"district"];
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.postalCode forKey:@"postalCode"];
}

+(User *)getObject
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *archivedObject = [defaults objectForKey:@"login_user"];
    return (User *)[NSKeyedUnarchiver unarchiveObjectWithData:archivedObject];
}

+(void)saveObject:(User *)object
{
    NSData *archivedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:archivedObject forKey:@"login_user"];
    [defaults synchronize];
}

+(User *)getObjectForUpdate
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *archivedObject = [defaults objectForKey:@"login_user_for_update"];
    return (User *)[NSKeyedUnarchiver unarchiveObjectWithData:archivedObject];
}

+(void)saveObjectForUpdate:(User *)object
{
    NSData *archivedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:archivedObject forKey:@"login_user_for_update"];
    [defaults synchronize];
}

@end
