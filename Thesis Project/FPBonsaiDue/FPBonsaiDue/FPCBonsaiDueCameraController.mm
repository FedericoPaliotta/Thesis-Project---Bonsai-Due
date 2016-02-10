//
//  FPCBonsaiDueCameraController.m
//  FPCBonsaiDue
//
//  Created by Federico Paliotta on 09/10/13.
//  Copyright (c) 2013 Federico Paliotta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "FPCBonsaiDueCameraController.h"
#import "FPCBonsaiDueCV.h"

@interface FPCBonsaiDueCameraController()

@property (nonatomic) UIImagePickerController *imagePickerController;
@property (nonatomic) FPCBonsaiDueCV *cv;
@property (nonatomic) AVCaptureDevice * device;

@end

@implementation FPCBonsaiDueCameraController


-(void)viewDidLoad
{
   [super viewDidLoad];
    //TOOLBAR
    self.toolbarView.tintColor = [UIColor greenColor];
    //ACTIVITY INDICATOR
   [self.processingImageIndicator stopAnimating];
    self.processingImageIndicator.hidden = YES;
    self.processingImageIndicator.color = [UIColor greenColor];
    //OPEN_CV
    self.cv = [[FPCBonsaiDueCV alloc] init];
   [self.cv setImageView:self.imageView];
   [self.imageView setImage:self.myImage];
   [self.cv viewDidLoad];

}

- (IBAction)showImagePickerForCamera:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;

    /*
    CGRect cameraFrame = imagePickerController.cameraOverlayView.frame;
    CGPoint cameraOrigin = cameraFrame.origin;
    CGSize cameraSize = cameraFrame.size;
    cameraOrigin.y += 88;
    cameraSize.height -= 88;
    cameraFrame.origin = cameraOrigin;
    cameraFrame.size = cameraSize;
    imagePickerController.cameraOverlayView.frame = cameraFrame;
*/
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];

}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.myImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self.imageView setImage:self.myImage];
    [self dismissViewControllerAnimated:YES completion:NULL];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Helper methods


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if(self.cv.videoCamera.running)
        [self.cv.videoCamera stop];
        [self flashLigh:NO];

}

- (IBAction)analyzeImage:(id)sender {
    
     self.takePictureButton.enabled = NO;
    //[self flashLigh:YES];

    if (!self.cv.videoCamera.running) {
        if (self.processingImageIndicator.isAnimating){
           [self.processingImageIndicator stopAnimating];
            self.processingImageIndicator.hidden = YES;
        }
        // First step
        [self.cv.videoCamera start];
        
    }
    else{
        [self flashLigh:YES];
        [self.cv.videoCamera stop];
         self.imageView.image = self.cv.last;
        [self.processingImageIndicator startAnimating];
         self.processingImageIndicator.hidden = NO;
        // Second step
        [self doCalculation];
        
        [self flashLigh:NO];
         self.takePictureButton.enabled = YES;
        
    }

    }



- (void)doCalculation
{
    dispatch_queue_t backgroundQueue = dispatch_queue_create("processing_images_queue", 0);
    
    // E stacca un thread!
    dispatch_async(backgroundQueue,
    ^{
        dispatch_async(dispatch_get_main_queue(),
        ^{
           [self.imageView setImage:[self.cv bgRemove:self.imageView.image]];
           [self.processingImageIndicator stopAnimating];
            self.processingImageIndicator.hidden = YES;

        });
    });
}

- (void)flashLigh: (BOOL)mode
{
     self.device = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo];
    [self.device lockForConfiguration:nil];

    if(mode)
        [self.device setTorchMode:AVCaptureTorchModeOn];
    else
        [self.device setTorchMode:AVCaptureTorchModeOff];
    [self.device unlockForConfiguration];
}

@end
