//
//  OrientationTestViewController.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/05/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OrientationTestViewController.h"

#import "QuartzHelpLibrary.h"

@implementation OrientationTestViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	BOOL hidden = self.navigationController.navigationBar.hidden;
	[self.navigationController setNavigationBarHidden:!hidden animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[self setTitle:NSStringFromClass([self class])];
	[self.navigationController.navigationBar setTranslucent:YES];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.navigationController.navigationBar setTranslucent:NO];	
}

- (void)showImage {
	int width = 48;
	int height = 32;
	int bytesPerPixel = 3;
	unsigned char *pixel = (unsigned char*)malloc(sizeof(unsigned char) * width * height * bytesPerPixel);
	for (int x = 0; x < width; x++) {
		for (int y = 0; y < height; y++) {
			if (y < height / 2 && x < width / 2) {
				pixel[y * width * 3 + x * 3 + 0] = 255;
				pixel[y * width * 3 + x * 3 + 1] = 0;
				pixel[y * width * 3 + x * 3 + 2] = 0;
			}
			else if (y <=height / 2 && x >= width / 2) {
				pixel[y * width * 3 + x * 3 + 0] = 0;
				pixel[y * width * 3 + x * 3 + 1] = 255;
				pixel[y * width * 3 + x * 3 + 2] = 0;
			}
			else if (y >= height / 2 && x < width / 2) {
				pixel[y * width * 3 + x * 3 + 0] = 0;
				pixel[y * width * 3 + x * 3 + 1] = 0;
				pixel[y * width * 3 + x * 3 + 2] = 255;
			}
			else if (y >= height / 2 && x >= width / 2) {
				pixel[y * width * 3 + x * 3 + 0] = 200;
				pixel[y * width * 3 + x * 3 + 1] = 200;
				pixel[y * width * 3 + x * 3 + 2] = 200;
			}
		}
	}
	
	CGImageRef source = CGImageCreateWithPixelBuffer(pixel, width, height, bytesPerPixel, QH_PIXEL_COLOR);
	
	[original setImage:[UIImage imageWithCGImage:source]];
	
	[true_up setImage:[UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationUp]];
	[true_down setImage:[UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationDown]];
	[true_left setImage:[UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationLeft]];
	[true_right setImage:[UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationRight]];
	[true_upMirrored setImage:[UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationUpMirrored]];
	[true_downMirrored setImage:[UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationDownMirrored]];
	[true_leftMirrored setImage:[UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationLeftMirrored]];
	[true_rightMirrored setImage:[UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationRightMirrored]];
	
	free(pixel);
	CGImageRelease(source);
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[self showImage];
}

@end
