//
//  FPCBonsaiDueCameraController.h
//  FPCBonsaiDue
//
//  Created by Federico Paliotta on 09/10/13.
//  Copyright (c) 2013 Federico Paliotta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface FPCBonsaiDueCameraController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (nonatomic) UIImage *myImage;

@property (nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbarView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *takePictureButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *processingImageIndicator;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *analyzeButton;



- (IBAction)analyzeImage:(id)sender;




@end
