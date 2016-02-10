//
//  FPCBonsaiDueMasterViewController.h
//  FPCBonsaiDue
//
//  Created by Federico Paliotta on 04/10/13.
//  Copyright (c) 2013 Federico Paliotta. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@class FPCBonsaiDataController;

@interface FPCBonsaiDueMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>


//@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@property (strong, nonatomic) FPCBonsaiDataController *bonsaiDataController;

-(IBAction)done:(UIStoryboardSegue *)segue;
-(IBAction)cancell:(UIStoryboardSegue *)segue;

@end
