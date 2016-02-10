//
//  FPCBonsai.h
//  FPCBonsaiDue
//
//  Created by Federico Paliotta on 04/10/13.
//  Copyright (c) 2013 Federico Paliotta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface FPCBonsai : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * variety;
@property (nonatomic) NSInteger age;
@property (nonatomic, copy) UIImage * avatar;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, copy) NSMutableDictionary * imagesCollection;

- (id)initWithName:(NSString *)name variety: (NSString *)variety age:(NSInteger)years;
- (id)initWithName:(NSString *)name variety: (NSString *)variety age:(NSInteger)years image:(UIImage *) avatar;
- (id)initWithDictionary:(NSDictionary *)data;

@end
