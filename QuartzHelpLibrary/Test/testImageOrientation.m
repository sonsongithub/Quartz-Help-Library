/*
 * Quartz Help Library
 * testImageOrientation.m
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

#import "testImageOrientation.h"

#import "QuartzHelpLibrary.h"

#import "testTool.h"

void makeImage(unsigned char **pixel, int *width, int *height, int *bytesPerPixel, UIImageOrientation orientation) {
	int defaultWidth = QH_ORIENTATION_TEST_WIDTH;
	int defaultHeight = QH_ORIENTATION_TEST_HEIGHT;
	int defaultBytesPerPixel = QH_ORIENTATION_TEST_BYTES_PER_PIXEL;
	
	unsigned char *source = (unsigned char*)malloc(sizeof(unsigned char) * (defaultWidth) * (defaultHeight) * (defaultBytesPerPixel));
	for (int x = 0; x < (defaultWidth); x++) {
		for (int y = 0; y < defaultHeight; y++) {
			if (y < defaultHeight / 2 && x < (*width) / 2) {
				source[y * (defaultWidth) * 3 + x * 3 + 0] = 255;
				source[y * (defaultWidth) * 3 + x * 3 + 1] = 0;
				source[y * (defaultWidth) * 3 + x * 3 + 2] = 0;
			}
			else if (y <= defaultHeight / 2 && x >= (defaultWidth) / 2) {
				source[y * (defaultWidth) * 3 + x * 3 + 0] = 0;
				source[y * (defaultWidth) * 3 + x * 3 + 1] = 255;
				source[y * (defaultWidth) * 3 + x * 3 + 2] = 0;
			}
			else if (y >= defaultHeight / 2 && x < (defaultWidth) / 2) {
				source[y * (defaultWidth) * 3 + x * 3 + 0] = 0;
				source[y * (defaultWidth) * 3 + x * 3 + 1] = 0;
				source[y * (defaultWidth) * 3 + x * 3 + 2] = 255;
			}
			else if (y >= defaultHeight / 2 && x >= (defaultWidth) / 2) {
				source[y * (defaultWidth) * 3 + x * 3 + 0] = 200;
				source[y * (defaultWidth) * 3 + x * 3 + 1] = 200;
				source[y * (defaultWidth) * 3 + x * 3 + 2] = 200;
			}
		}
	}
	
	switch(orientation) {
		case UIImageOrientationUp:
			*width = defaultWidth;
			*height = defaultHeight;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				for (int y = 0; y < (*height); y++) {
					(*pixel)[y * (*width) * 3 + x * 3 + 0] = source[y * (defaultWidth) * 3 + x * 3 + 0];
					(*pixel)[y * (*width) * 3 + x * 3 + 1] = source[y * (defaultWidth) * 3 + x * 3 + 1];
					(*pixel)[y * (*width) * 3 + x * 3 + 2] = source[y * (defaultWidth) * 3 + x * 3 + 2];
				}
			}
			break;
		case UIImageOrientationUpMirrored:
			*width = defaultWidth;
			*height = defaultHeight;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				int tx = *width - 1 - x;
				for (int y = 0; y < (*height); y++) {
					(*pixel)[y * (*width) * 3 + tx * 3 + 0] = source[y * (defaultWidth) * 3 + x * 3 + 0];
					(*pixel)[y * (*width) * 3 + tx * 3 + 1] = source[y * (defaultWidth) * 3 + x * 3 + 1];
					(*pixel)[y * (*width) * 3 + tx * 3 + 2] = source[y * (defaultWidth) * 3 + x * 3 + 2];
				}
			}
			break;
		case UIImageOrientationDown:
			*width = defaultWidth;
			*height = defaultHeight;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				int tx = *width - 1 - x;
				for (int y = 0; y < (*height); y++) {
					int ty = *height - 1 - y;
					(*pixel)[ty * (*width) * 3 + tx * 3 + 0] = source[y * (defaultWidth) * 3 + x * 3 + 0];
					(*pixel)[ty * (*width) * 3 + tx * 3 + 1] = source[y * (defaultWidth) * 3 + x * 3 + 1];
					(*pixel)[ty * (*width) * 3 + tx * 3 + 2] = source[y * (defaultWidth) * 3 + x * 3 + 2];
				}
			}
			break;
			
		case UIImageOrientationDownMirrored:
			*width = defaultWidth;
			*height = defaultHeight;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				for (int y = 0; y < (*height); y++) {
					int ty = *height - 1 - y;
					(*pixel)[ty * (*width) * 3 + x * 3 + 0] = source[y * (defaultWidth) * 3 + x * 3 + 0];
					(*pixel)[ty * (*width) * 3 + x * 3 + 1] = source[y * (defaultWidth) * 3 + x * 3 + 1];
					(*pixel)[ty * (*width) * 3 + x * 3 + 2] = source[y * (defaultWidth) * 3 + x * 3 + 2];
				}
			}
			break;
		case UIImageOrientationLeft:
			*width = defaultHeight;
			*height = defaultWidth;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				for (int y = 0; y < (*height); y++) {
					int tx = *height - y - 1;
					int ty = x;
					(*pixel)[y * (*width) * 3 + x * 3 + 0] = source[ty * (defaultWidth) * 3 + tx * 3 + 0];
					(*pixel)[y * (*width) * 3 + x * 3 + 1] = source[ty * (defaultWidth) * 3 + tx * 3 + 1];
					(*pixel)[y * (*width) * 3 + x * 3 + 2] = source[ty * (defaultWidth) * 3 + tx * 3 + 2];
				}
			}
			break;
		case UIImageOrientationLeftMirrored:
			*width = defaultHeight;
			*height = defaultWidth;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				for (int y = 0; y < (*height); y++) {
					int tx = y;
					int ty = x;
					(*pixel)[y * (*width) * 3 + x * 3 + 0] = source[ty * (defaultWidth) * 3 + tx * 3 + 0];
					(*pixel)[y * (*width) * 3 + x * 3 + 1] = source[ty * (defaultWidth) * 3 + tx * 3 + 1];
					(*pixel)[y * (*width) * 3 + x * 3 + 2] = source[ty * (defaultWidth) * 3 + tx * 3 + 2];
				}
			}
			break;
		case UIImageOrientationRight:
			*width = defaultHeight;
			*height = defaultWidth;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				for (int y = 0; y < (*height); y++) {
					int tx = y;
					int ty = *width - x - 1;
					(*pixel)[y * (*width) * 3 + x * 3 + 0] = source[ty * (defaultWidth) * 3 + tx * 3 + 0];
					(*pixel)[y * (*width) * 3 + x * 3 + 1] = source[ty * (defaultWidth) * 3 + tx * 3 + 1];
					(*pixel)[y * (*width) * 3 + x * 3 + 2] = source[ty * (defaultWidth) * 3 + tx * 3 + 2];
				}
			}
			break;
		case UIImageOrientationRightMirrored:
			*width = defaultHeight;
			*height = defaultWidth;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				for (int y = 0; y < (*height); y++) {
					int tx = *height - y - 1;
					int ty = *width - x - 1;
					(*pixel)[y * (*width) * 3 + x * 3 + 0] = source[ty * (defaultWidth) * 3 + tx * 3 + 0];
					(*pixel)[y * (*width) * 3 + x * 3 + 1] = source[ty * (defaultWidth) * 3 + tx * 3 + 1];
					(*pixel)[y * (*width) * 3 + x * 3 + 2] = source[ty * (defaultWidth) * 3 + tx * 3 + 2];
				}
			}
			break;
		default:
			break;
	}
	free(source);
}

void testImageOrientation() {
	int tolerance = 2;
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
	
	NSMutableArray *titles = [NSMutableArray arrayWithCapacity:8];
	[titles addObject:NSLocalizedString(@"UIImageOrientationUp", nil)];
	[titles addObject:NSLocalizedString(@"UIImageOrientationUpMirrored", nil)];
	[titles addObject:NSLocalizedString(@"UIImageOrientationDown", nil)];
	[titles addObject:NSLocalizedString(@"UIImageOrientationDownMirrored", nil)];
	[titles addObject:NSLocalizedString(@"UIImageOrientationLeft", nil)];
	[titles addObject:NSLocalizedString(@"UIImageOrientationLeftMirrored", nil)];
	[titles addObject:NSLocalizedString(@"UIImageOrientationRight", nil)];
	[titles addObject:NSLocalizedString(@"UIImageOrientationRightMirrored", nil)];
	
	for (int i = 0; i < 8; i++) {
		printf("%s\n", [[titles objectAtIndex:i] UTF8String]);
		int width = QH_ORIENTATION_TEST_WIDTH;
		int height = QH_ORIENTATION_TEST_HEIGHT;
		int bytesPerPixel = QH_ORIENTATION_TEST_BYTES_PER_PIXEL;
		unsigned char *pixel = NULL;
		
		makeImage(&pixel, &width, &height, &bytesPerPixel, rot[i]);
		UIImage *image = [UIImage imageWithCGImage:source scale:1 orientation:rot[i]];
		CGImageRef rotated = [image createCGImageRotated];
		
		int r_width = 0;
		int r_height = 0;
		int r_bytesPerPixel = 0;
		unsigned char *r_pixel = NULL;
		
		CGCreatePixelBufferWithImage(rotated, &r_pixel, &r_width, &r_height, &r_bytesPerPixel, QH_PIXEL_COLOR);
		
		assert(width == r_width);
		assert(height == r_height);
		assert(bytesPerPixel == r_bytesPerPixel);
		assert(compareBuffersWithXandY(pixel, r_pixel, r_width, r_height, r_bytesPerPixel, tolerance));

		free(pixel);
		free(r_pixel);
	}
	CGImageRelease(source);
	printf("testImageOrientation OK\n\n");
}
