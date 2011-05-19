//
//  OrientationTestViewController.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/05/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OrientationTestViewController.h"

#import "QuartzHelpLibrary.h"

#import "testImageOrientation.h"

@implementation OrientationTestViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	BOOL hidden = self.navigationController.navigationBar.hidden;
	[self.navigationController setNavigationBarHidden:!hidden animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self setTitle:NSStringFromClass([self class])];
	[self.navigationController.navigationBar setTranslucent:YES];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.navigationController.navigationBar setTranslucent:NO];	
}

- (void)showImage {
	int width = QH_ORIENTATION_TEST_WIDTH;
	int height = QH_ORIENTATION_TEST_HEIGHT;
	int bytesPerPixel = QH_ORIENTATION_TEST_BYTES_PER_PIXEL;
	unsigned char *pixel = NULL;
	
	makeImage(&pixel, &width, &height, &bytesPerPixel, UIImageOrientationUp);
	CGImageRef source = CGImageCreateWithPixelBuffer(pixel, width, height, bytesPerPixel, QH_PIXEL_COLOR);
	free(pixel);
	
	int rot[8];
	{
		int *p = rot;
		*p++ = UIImageOrientationUp;
		*p++ = UIImageOrientationUpMirrored;
		*p++ = UIImageOrientationDown;
		*p++ = UIImageOrientationDownMirrored;
		*p++ = UIImageOrientationLeft;
		*p++ = UIImageOrientationLeftMirrored;
		*p++ = UIImageOrientationRight;
		*p++ = UIImageOrientationRightMirrored;
	}
	
	UIImageView *trueImageViews[8];
	{
		UIImageView **p = trueImageViews;
		*p++ = true_up;
		*p++ = true_upMirrored;
		*p++ = true_down;
		*p++ = true_downMirrored;
		*p++ = true_left;
		*p++ = true_leftMirrored;
		*p++ = true_right;
		*p++ = true_rightMirrored;
	}
	
	UIImageView *testImageViews[8];
	{
		UIImageView **p = testImageViews;
		*p++ = up;
		*p++ = upMirrored;
		*p++ = down;
		*p++ = downMirrored;
		*p++ = left;
		*p++ = leftMirrored;
		*p++ = right;
		*p++ = rightMirrored;
	}
	
	for (int i = 0; i < 8; i++) {
		UIImage *image = [UIImage imageWithCGImage:source scale:1 orientation:rot[i]];
		[trueImageViews[i] setImage:image];
		[testImageViews[i] setImage:[image getRotatedImage]];
	}

	CGImageRelease(source);
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	[self showImage];
}

@end
