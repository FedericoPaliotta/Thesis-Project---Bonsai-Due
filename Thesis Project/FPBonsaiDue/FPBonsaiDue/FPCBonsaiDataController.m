//
//  FPCBonsaiControllerData.m
//  FPCBonsaiDue
//
//  Created by Federico Paliotta on 04/10/13.
//  Copyright (c) 2013 Federico Paliotta. All rights reserved.
//

#import "FPCBonsaiDataController.h"
#import "FPCBonsai.h"

@interface FPCBonsaiDataController()

@property (nonatomic, readwrite) NSMutableArray *varietiesList;

-(void)initializeDefaultFPCBonsaiList;

@end
@implementation FPCBonsaiDataController

-(void)initializeDefaultFPCBonsaiList{
    NSMutableArray * newFPCBonsaiList = [[NSMutableArray alloc] init];
    self.masterFPCBonsaiList = newFPCBonsaiList;
}

- (id)init {
    if (self = [super init]) {
        [self initializeDefaultFPCBonsaiList];
        return self;
    }
    return nil;
}


-(void)setMasterFPCBonsaiList:(NSMutableArray *)newMasterFPCBonsaiList{
    if(_masterFPCBonsaiList!=newMasterFPCBonsaiList){
        _masterFPCBonsaiList = [newMasterFPCBonsaiList mutableCopy];
    }
}

- (NSUInteger)countOfList{
    return [self.masterFPCBonsaiList count];
}

- (FPCBonsai *)objectInListAtIndex:(NSUInteger)theIndex{
    return [self.masterFPCBonsaiList objectAtIndex:theIndex];
}

- (void)addFPCBonsai:(FPCBonsai *)aFPCBonsai{
    [self.masterFPCBonsaiList addObject:aFPCBonsai];
}

- (UIImage *)varietyAvatarImage:(NSString *)imageFileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:imageFileName ofType:@"png"];
    UIImage *avatar = [[UIImage alloc] initWithContentsOfFile:path];
    
    return avatar;
}

- (NSArray *)varietiesArrayList:(NSString *)propertyListFileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:propertyListFileName ofType:@"plist"];
    NSArray *varietiesArray = [NSArray arrayWithContentsOfFile:path];
    self.varietiesList = [NSMutableArray array];
    for(NSDictionary *data in [varietiesArray objectAtIndex:0]){
        [self.varietiesList addObject:[data objectForKey:@"familly"]];

    }
    return self.varietiesList;
}

//NON USATO
- (BOOL)validateFPCBonsaiData:(FPCBonsai *)bonsai
{
    return YES;
}
@end















