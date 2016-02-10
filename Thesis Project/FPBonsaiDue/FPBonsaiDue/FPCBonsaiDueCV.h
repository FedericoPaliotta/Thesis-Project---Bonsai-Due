//
//  FPCBonsaiDueCV.h
//  FPCBonsaiDue
//
//  Created by Federico Paliotta on 13/10/13.
//  Copyright (c) 2013 Federico Paliotta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <opencv2/opencv.hpp>
#import <opencv2/highgui/cap_ios.h>
#import <opencv2/objdetect/objdetect.hpp>
#import <opencv2/imgproc/imgproc_c.h>



using namespace cv;
using namespace std;


@interface FPCBonsaiDueCV : UIViewController <CvVideoCameraDelegate>
{
    CascadeClassifier cascade;
}

@property (nonatomic) CvVideoCamera *videoCamera;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIImage *last;


-(cv::Mat)cvMatFromUIImage:(UIImage *)image;

- (cv::Mat)cvMatGrayFromUIImage:(UIImage *)image;

-(UIImage *) toGrayscale:(UIImage *) rgbImage;

-(UIImage *)bgRemove:(UIImage *) image;

@end
