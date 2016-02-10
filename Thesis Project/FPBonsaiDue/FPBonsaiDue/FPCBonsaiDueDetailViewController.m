//
//  FPCBonsaiDueDetailViewController.m
//  FPCBonsaiDue
//
//  Created by Federico Paliotta on 04/10/13.
//  Copyright (c) 2013 Federico Paliotta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "FPCBonsaiDueDetailViewController.h"
#import "FPCBonsaiDueCameraController.h"
#import "FPCBonsai.h"


@interface FPCBonsaiDueDetailViewController ()
- (void)configureView;
@end

@implementation FPCBonsaiDueDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newFPCBonsaiItem
{
    if (_myFPCBonsai != newFPCBonsaiItem) {
        _myFPCBonsai = newFPCBonsaiItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor greenColor];


    if (self.myFPCBonsai)
    {
        self.name.text = [NSString stringWithFormat:@"•%@",self.myFPCBonsai.name];
        self.variety.text = self.myFPCBonsai.variety;
        self.age.text = [[NSString alloc] initWithFormat:@"%ld", (long)self.myFPCBonsai.age];
        self.avatarImageView.image = self.myFPCBonsai.avatar;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Camera actions methods


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"DoneWithCameraSegue"]) {
        FPCBonsaiDueCameraController *cameraView = [segue destinationViewController];
        cameraView.myImage = [[UIImage alloc] initWithContentsOfFile:
                              [[NSBundle mainBundle] pathForResource:self.myFPCBonsai.variety
                                                              ofType:@"png"]];
        
        
       //cameraView.myImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Sample2" ofType:@"JPG"]];

        //[cameraView showImagePickerForCameraDirectly:self.actionButton];
    }
}

@end






