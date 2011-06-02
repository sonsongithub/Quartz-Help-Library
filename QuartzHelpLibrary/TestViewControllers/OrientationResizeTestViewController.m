//
//  OrientationResizeTestViewController.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/06/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OrientationResizeTestViewController.h"

#import "QuartzHelpLibrary.h"
#import "testImageOrientation.h"

@implementation OrientationResizeTestViewController

+ (NSString*)testDescription {
	return NSLocalizedString(@"UIImage orientation and resize", nil);
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
		[testImageViews[i] setImage:[image getRotatedImageWithResizing:0.5]];
	}
	
	CGImageRelease(source);
}

@end
