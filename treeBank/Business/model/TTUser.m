//
//  TTUser.m
//  treeBank
//
//  Created by kebi on 16/4/23.
//  Copyright © 2016年 kebi. All rights reserved.
//

#import "TTUser.h"

@implementation TTUser


-(void)parseData:(NSDictionary*)dics{
    
    self.mobile =[dics objectForKey:@"mobile"];
    self.deviceno =[dics objectForKey:@"deviceno"];
    self.banknum = [[dics objectForKey:@"banknum"]integerValue];
    self.auditstatus = [[dics  objectForKey:@"auditstatus"]integerValue];
    self.authstatus =[[dics objectForKey:@"authstatus"]integerValue];
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_mobile forKey:@"mobile"];
    [aCoder encodeObject:_deviceno forKey:@"deviceno"];
    [aCoder encodeObject:@(_banknum) forKey:@"banknum"];
    [aCoder encodeObject:@(_auditstatus) forKey:@"auditstatus"];
    [aCoder encodeObject:@(_authstatus) forKey:@"authstatus"];
    [aCoder encodeObject:_token forKey:@"token"];
    [aCoder encodeObject:_objId forKey:@"objid"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self =[super init];
    _mobile =[aDecoder decodeObjectForKey:@"mobile"];
    _deviceno =[aDecoder decodeObjectForKey:@"deviceno"];
    _banknum =[[aDecoder decodeObjectForKey:@"banknum"]integerValue];
    _auditstatus =[[aDecoder decodeObjectForKey:@"auditstatus"]integerValue];
    _authstatus =[[aDecoder decodeObjectForKey:@"authstatus"]integerValue];
    _token =[aDecoder decodeObjectForKey:@"token"];
    _objId =[aDecoder decodeObjectForKey:@"objid"];
    return self;
}
@end
