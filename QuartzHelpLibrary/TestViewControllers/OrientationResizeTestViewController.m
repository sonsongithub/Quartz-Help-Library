/*
 * Quartz Help Library
 * OrientationResizeTestViewController.m
 *
 * Copyright (c) Yuichi YOSHIDA, 11/06/01
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
