/*
 * Quartz Help Library
 * TestUIImageViewFromRGBPixel.m
 *
 * Copyright (c) Yuichi YOSHIDA, 11/04/20
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

#import "TestUIImageViewFromRGBPixel.h"

#import "QuartzHelpLibrary.h"

@implementation TestUIImageViewFromRGBPixel

- (void)addImage {
	
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
	
	CGImageRef image = CGImageCreateWithPixelBuffer(original, originalWidth, originalHeight, QH_BYTES_PER_PIXEL_24BIT, QH_PIXEL_COLOR);
	
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
