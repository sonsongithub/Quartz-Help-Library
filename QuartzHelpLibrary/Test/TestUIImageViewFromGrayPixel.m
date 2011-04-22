//
//  TestUIImageViewFromGrayPixel.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/04/22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestUIImageViewFromGrayPixel.h"

#import "QuartzHelpLibrary.h"

@implementation TestUIImageViewFromGrayPixel

- (void)addImage {

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
	
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:image]];
	[self addSubview:imageView];
	[imageView release];
	
	CGImageRelease(image);
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self addImage];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
		[self addImage];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
