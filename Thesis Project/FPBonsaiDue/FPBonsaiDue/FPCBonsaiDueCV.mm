//
//  FPCBonsaiDueCV.m
//  FPCBonsaiDue
//
//  Created by Federico Paliotta on 13/10/13.
//  Copyright (c) 2013 Federico Paliotta. All rights reserved.
//

#import "FPCBonsaiDueCV.h"
#import <opencv2/opencv.hpp>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


NSString* const CascadeFilename = @"leavesCascade";
const int HaarOptions = CV_HAAR_FIND_BIGGEST_OBJECT | CV_HAAR_DO_ROUGH_SEARCH ;


@implementation FPCBonsaiDueCV

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:self.imageView];
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;
    self.videoCamera.delegate = self;

    NSString *CascadePath =[[NSBundle mainBundle] pathForResource:CascadeFilename ofType:@"xml"];
    cascade.load([CascadePath UTF8String]);
}



                                                #pragma mark - Protocol CvVidoCameraDelegate



#ifdef __cplusplus
-(void)processImage:(cv::Mat &)image
{
    Mat greyscaleFrame;
    cv::cvtColor(image, greyscaleFrame, CV_BGR2GRAY);
    cv::equalizeHist(greyscaleFrame, greyscaleFrame);
    
    std::vector<cv::Rect> faces;
    
    //Haar-feauture like object detection
    cascade.detectMultiScale(greyscaleFrame, faces, 1.1, 2, HaarOptions, cv::Size(30, 80));
    
    for(int i = 0; i < faces.size(); i++)
    {
        self.last = [self UIImageFromCVMat:image];
        cv::Point pt1(faces[i].x + faces[i].width , faces[i].y + faces[i].height);
        cv::Point pt2(faces[i].x, faces[i].y);
        
        cv::rectangle(image, pt1, pt2, cvScalar(0, 255, 0, 0), 1, 8, 0);
        
        cv::Point cntr((faces[i].x + (faces[i].width)/2), faces[i].y + (faces[i].height/2));
        //cv::circle(image, cntr, (faces[i].x + faces[i].width)/3, cvScalar(0, 255, 0, 0), 1, 8, 0);
        
        
        //cv::Size axes(2*(faces[i].height)/3, (faces[i].width)/2);
        //cv::ellipse(image, cntr, axes, 90, 360, 0, cvScalar(0, 255, 0, 0), 1, 8, 0);
    }
}
#endif






                                                    #pragma mark BACKGROUND REMOVAL




#ifdef __cplusplus
-(UIImage *)bgRemove:(UIImage *) image
{
    
    cv::Mat present = [self cvMatFromUIImage:image];
    
//    vector<Mat> channels(3);
//    cv::Mat chBlue, chGreen, chRed;
//    cv::split(present, channels);
//    chBlue = channels[0];
//    chGreen = channels[1];
//    chRed = channels[2];
    
    cv::Mat src = [self cvMatGrayFromUIImage:image];
    cv::Mat foreground, thras, median, gauss,canny;
    vector< vector <cv::Point>> contours;
    cv::Size gausSize(13, 13);
   
    
    medianBlur(src, median, 13);
    GaussianBlur(median, gauss, gausSize, 1.9);
    Canny(gauss, foreground, 0.01, 0.75);

    //threshold(chGreen,thras, 15, 50, THRESH_BINARY);

    //cv::Mat kernel = cv::Mat(3, 3, CV_8UC1, int(0));
    //kernel.at<int>(1,1) = 255;
    
//    kernel.at<int>(0,0) = 0, kernel.at<int>(0,1) = 255, kernel.at<int>(0,2) = 0;
//    kernel.at<int>(1,0) = 255, kernel.at<int>(1,1) = 255, kernel.at<int>(1,2) = 255;
//    kernel.at<int>(2,0) = 0, kernel.at<int>(2,1) = 255, kernel.at<int>(2,2) = 0;
   
    //erode(foreground,foreground,cv::Mat());
    
    //dilate(foreground,foreground,cv::Mat());
    
    findContours(foreground, contours, CV_RETR_CCOMP, CV_CHAIN_APPROX_SIMPLE);
    
    drawContours(present, contours, -1, CV_RGB(0, 0, 255), 4);
    
    return [self UIImageFromCVMat:present];

    
/*   Mat result;
//    vector<KeyPoint> keyPoints;
//    vector<cv::Point> hierarchy;
//    vector< vector <cv::Point>> contours;
//    vector< vector <cv::Point>> approxContours;
    
//        SimpleBlobDetector::Params params;
//        params.thresholdStep = 10;
//        params.minThreshold = 50;
//        params.maxThreshold = 220;
//        params.minRepeatability = 2;
//        params.minDistBetweenBlobs = 10;
//    
//        params.filterByColor = true;
//        params.blobColor = 0;
//
//        params.filterByArea = true; // Got a thread bad access err if false... 4 god sick!! wtf!!!
//        params.minArea = 10;
//        params.maxArea = std::numeric_limits<float>::max();
//    
//        params.filterByCircularity = true;
//        params.minCircularity = 0.8f;
//        params.maxCircularity = std::numeric_limits<float>::max();
//        
//        params.filterByInertia = false;
//        //params.minInertiaRatio = 0.6;
//        params.minInertiaRatio = 0.1f;
//        params.maxInertiaRatio = std::numeric_limits<float>::max();
//        
//        params.filterByConvexity = true;
//        //params.minConvexity = 0.8;
//        params.minConvexity = 1.0f;
//        params.maxConvexity = std::numeric_limits<float>::max();
//    
////    SimpleBlobDetector blobDetector( params );
////    blobDetector.create("SimpleBlob");
////    
////    blobDetector.detect(src, keyPoints);
////    drawKeypoints(src, keyPoints, result, CV_RGB(0,255,0), DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
//    
//    findContours(src, contours, hierarchy, CV_RETR_TREE, IPL_BORDER_REPLICATE);
//    
//    
////    for(std::vector<KeyPoint>::iterator blobIterator = keyPoints.begin(); blobIterator != keyPoints.end(); blobIterator++){
////     }
////    
////    for(int i=0; i<keyPoints.size(); i++ )
////    {
////        cv::floodFill(result,keyPoints[i].pt, Scalar::all((i+1)*255/(keyPoints.size()+1)));
////    }
////    
//
//    approxContours.resize( contours.size() );
//    
//    for( int i = 0; i < contours.size(); ++i )
//    {
//        approxPolyDP( Mat(contours[i]), approxContours[i], 4, 1 );
//        drawContours( result, contours, i, CV_RGB(rand()&255, rand()&255, rand()&255), hierarchy, 0 );
//        drawContours( result, approxContours, i, CV_RGB(rand()&255, rand()&255, rand()&255) );
//    }
*/
}
#endif







                                                    #pragma mark UIImage ----> Mat object :




- (cv::Mat)cvMatFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    return cvMat;
}

- (cv::Mat)cvMatGrayFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC1); // 8 bits per component, 1 channel
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNone |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    return cvMat;
}




                                            #pragma mark Mat object ----> UIImage (reverse process):





-(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                              //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef
                                              scale:1.0
                                        orientation: UIImageOrientationUp]; /* occore ruotare a destra di
                                                                                  π/2 che sennò di base viene storta 
                                                                                */
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}


-(UIImage *) toGrayscale:(UIImage *) rgbImage
{
    cv::Mat matImage = [self cvMatFromUIImage:rgbImage];
    cv::Mat greyMatImage;
    cv::cvtColor(matImage, greyMatImage, CV_BGR2GRAY);
    UIImage *greyImage = [self UIImageFromCVMat:greyMatImage];
    return greyImage;
}


@end
