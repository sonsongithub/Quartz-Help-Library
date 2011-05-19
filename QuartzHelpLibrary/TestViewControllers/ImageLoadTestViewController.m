/*
 * Quartz Help Library
 * ImageLoadTestViewController.m
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

#import "ImageLoadTestViewController.h"

#import "QuartzHelpLibrary.h"

@implementation ImageLoadTestViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self setTitle:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// make file path
	NSArray *paths = [NSArray arrayWithObjects:
					  [[NSBundle mainBundle] pathForResource:@"testImage_Gray_JPG24.jpg" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_Gray_PNG8.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_Gray_PNG8Alpha.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_Gray_PNG24.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_Gray_PNG24Alpha.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_RGB_JPG24.jpg" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_RGB_PNG8.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_RGB_PNG24.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_RGB_PNG24Alpha.png" ofType:nil],
					  nil];
	
	UIImageView *imageViews[9];
	
	imageViews[0] = imageView01;
	imageViews[1] = imageView02;
	imageViews[2] = imageView03;
	imageViews[3] = imageView04;
	imageViews[4] = imageView05;
	imageViews[5] = imageView06;
	imageViews[6] = imageView07;
	imageViews[7] = imageView08;
	imageViews[8] = imageView09;
	
	UIImageView **p = imageViews;
	
	// update image views
	for (NSString *path in paths) {
		unsigned char *pixel = NULL;
		int width, height, bytesPerPixel;
		printf("Image file2 = %s\n", [[path lastPathComponent] UTF8String]);
		CGImageRef imageRef = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
		CGImageDumpImageInformation(imageRef);
		
		CGCreatePixelBufferWithImage(imageRef, &pixel, &width, &height, &bytesPerPixel, QH_PIXEL_COLOR);
		
		CGImageRef duplicatedImage = CGImageCreateWithPixelBuffer(pixel, width, height, QH_BYTES_PER_PIXEL_24BIT, QH_PIXEL_COLOR);
		
		UIImageView *v = *p;
		
		[v setImage:[UIImage imageWithCGImage:duplicatedImage]];
		
		p++;
		
		free(pixel);
	}
}

@end
