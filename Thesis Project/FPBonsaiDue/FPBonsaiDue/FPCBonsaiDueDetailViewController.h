//
//  FPCBonsaiDueDetailViewController.h
//  FPCBonsaiDue
//
//  Created by Federico Paliotta on 04/10/13.
//  Copyright (c) 2013 Federico Paliotta. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FPCBonsai;

@interface FPCBonsaiDueDetailViewController : UITableViewController

@property (strong, nonatomic) FPCBonsai * myFPCBonsai;
@property (weak, nonatomic) IBOutlet UILabel * name;
@property (weak, nonatomic) IBOutlet UILabel * variety;
@property (weak, nonatomic) IBOutlet UILabel * age;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButton;


@end
