//
//  FPCBonsai.m
//  FPCBonsaiDue
//
//  Created by Federico Paliotta on 04/10/13.
//  Copyright (c) 2013 Federico Paliotta. All rights reserved.
//

#import "FPCBonsai.h"

@implementation FPCBonsai

- (id)initWithName:(NSString *)name variety:(NSString *)variety age:(NSInteger)years
{
    self = [super init];
    if (self) {
        _name = name;
        _variety = variety;
        _age = years;
        return self;
    }
    return nil;
}

- (id)initWithName:(NSString *)name variety:(NSString *)variety age:(NSInteger)years image:(UIImage *) avatar
{
    self = [super init];
    if (self) {
        _name = name;
        _variety = variety;
        _age = years;
        _avatar = avatar;
        return self;
    }
    return nil;
}

-(id)initWithDictionary:(NSDictionary *)data
{
    if((self = [super init])){
        self.avatar = [data objectForKey:@"picture"];
        self.variety = [data objectForKey:@"familly"];
        NSString *theUrl = [data objectForKey:@"url"];
        if(theUrl) self.url = [[NSURL alloc] initWithString:theUrl];
    }
    return self;
}


@end
