//
//  TestDrawCGImageFromGrayPixel.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/04/22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestDrawCGImageFromGrayPixel.h"

#import "QuartzHelpLibrary.h"

@implementation TestDrawCGImageFromGrayPixel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)makeAndDrawGrayPixels {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// original pixel data
	int originalWidth = 32;
	int originalHeight = 32;
	unsigned char* original = (unsigned char*)malloc(sizeof(unsigned char) * originalWidth * originalHeight);
	
	// make test pattern
	for (int y = 0; y < originalHeight; y++) {
		for (int x = 0; x < originalWidth; x++) {
			if (y <= originalHeight / 2 && x <= originalWidth / 2) {
				original[y * originalWidth + x] = 0;
			}
			if (y <= originalHeight / 2 && x > originalWidth / 2) {
				original[y * originalWidth + x] = 85;
			}
			if (y > originalHeight / 2 && x <= originalWidth / 2) {
				original[y * originalWidth + x] = 170;
			}
			if (y > originalHeight / 2 && x > originalWidth / 2) {
				original[y * originalWidth + x] = 255;
			}
		}
	}
	
	CGImageRef image = CGImageGrayColorCreateWithGrayPixelBuffer(original, originalWidth, originalHeight);
	
	// CGImage is inverted, vertically
	CGContextTranslateCTM(context, 0, originalHeight);
	CGContextScaleCTM(context, 1, -1);
	CGContextDrawImage(context, CGRectMake(0, 0, originalWidth, originalHeight), image);
}

- (void)drawRect:(CGRect)rect {
	[self makeAndDrawGrayPixels];
}

- (void)dealloc {
    [super dealloc];
}

@end
