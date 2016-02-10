//
//  FPCBonsaiControllerData.h
//  FPCBonsaiDue
//
//  Created by Federico Paliotta on 04/10/13.
//  Copyright (c) 2013 Federico Paliotta. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FPCBonsai;

@interface FPCBonsaiDataController : NSObject

@property (nonatomic, copy) NSMutableArray *masterFPCBonsaiList;
@property (nonatomic, readonly) NSMutableArray *varietiesList;

- (NSUInteger)countOfList;
- (FPCBonsai *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addFPCBonsai:(FPCBonsai *)aFPCBonsai;

- (UIImage *)varietyAvatarImage:(NSString *)imageFileName;
- (NSArray *)varietiesArrayList:(NSString *)propertyListFileName;

//NON USATO
- (BOOL)validateFPCBonsaiData:(FPCBonsai *)bonsai;

@end
