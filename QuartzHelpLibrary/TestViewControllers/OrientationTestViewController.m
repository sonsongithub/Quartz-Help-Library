/*
 * Quartz Help Library
 * OrientationTestViewController.m
 *
 * Copyright (c) Yuichi YOSHIDA, 11/05/19
 * All rights reserved.
 * 
 * BSD License
 *
 * Redistribution and use in source and binary forms, with or without modification, are 
 * permitted provided that the following conditions are met:
 * - Redistributions of source code must retain the above copyright notice, this list of
 *  conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, this list
 *  of conditions and the following disclaimer in the documentation and/or other materia
 * ls provided with the distribution.
 * - Neither the name of the "Yuichi Yoshida" nor the names of its contributors may be u
 * sed to endorse or promote products derived from this software without specific prior 
 * written permission.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY E
 * XPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES O
 * F MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SH
 * ALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENT
 * AL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROC
 * UREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS I
 * NTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRI
 * CT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF T
 * HE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
