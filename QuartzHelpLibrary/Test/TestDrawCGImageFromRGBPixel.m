//
//  TestDrawCGImageFromRGBPixel.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/04/22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestDrawCGImageFromRGBPixel.h"

#import "QuartzHelpLibrary.h"

@implementation TestDrawCGImageFromRGBPixel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)makeAndDrawRGBPixels {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// original pixel data
	int originalWidth = 32;
	int originalHeight = 32;
	unsigned char* original = (unsigned char*)malloc(sizeof(unsigned char) * originalWidth * originalHeight * 3);
	
	// make test pattern
	for (int x = 0; x < originalWidth; x++) {
		for (int y = 0; y < originalHeight; y++) {
			if (y <= originalHeight / 2 && x <= originalWidth / 2) {
				original[y * originalWidth * 3 + x * 3 + 0] = 255;
				original[y * originalWidth * 3 + x * 3 + 1] = 0;
				original[y * originalWidth * 3 + x * 3 + 2] = 0;
			}
			else if (y <= originalHeight / 2 && x > originalWidth / 2) {
				original[y * originalWidth * 3 + x * 3 + 0] = 0;
				original[y * originalWidth * 3 + x * 3 + 1] = 255;
				original[y * originalWidth * 3 + x * 3 + 2] = 0;
			}
			else if (y > originalHeight / 2 && x <= originalWidth / 2) {
				original[y * originalWidth * 3 + x * 3 + 0] = 0;
				original[y * originalWidth * 3 + x * 3 + 1] = 0;
				original[y * originalWidth * 3 + x * 3 + 2] = 255;
			}
			else if (y > originalHeight / 2 && x > originalWidth / 2) {
				original[y * originalWidth * 3 + x * 3 + 0] = 255;
				original[y * originalWidth * 3 + x * 3 + 1] = 255;
				original[y * originalWidth * 3 + x * 3 + 2] = 255;
			}
		}
	}
	
	CGImageRef image = CGImageRGBColorCreateWithRGBPixelBuffer(original, originalWidth, originalHeight);
	
	// CGImage is inverted, vertically
	CGContextTranslateCTM(context, 0, originalHeight);
	CGContextScaleCTM(context, 1, -1);
	CGContextDrawImage(context, CGRectMake(0, 0, originalWidth, originalHeight), image);
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	[self makeAndDrawRGBPixels];
}

- (void)dealloc {
    [super dealloc];
}

@end
