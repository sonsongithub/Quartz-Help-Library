/*
 * Quartz Help Library
 * test.m
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

#import "test.h"

#include "QuartzHelpLibrary.h"

#import "testTool.h"
#import "testImageOrientation.h"

#pragma mark -
#pragma mark CGImage and image file

typedef enum {
	QH_TEST_JPG = 0,
	QH_TEST_PNG = 1,
}QH_TEST_IMAGE_TYPE;

void copyTestPixelPattern(unsigned char *pixel, int width, int height, QH_PIXEL_TYPE testType) {
	if (testType == QH_PIXEL_GRAYSCALE) {
		// make test pattern
		for (int y = 0; y < height; y++) {
			for (int x = 0; x < width; x++) {
				if (y <= height / 2 && x <= width / 2) {
					pixel[y * width + x] = 0;
				}
				if (y <= height / 2 && x > width / 2) {
					pixel[y * width + x] = 85;
				}
				if (y > height / 2 && x <= width / 2) {
					pixel[y * width + x] = 170;
				}
				if (y > height / 2 && x > width / 2) {
					pixel[y * width + x] = 255;
				}
			}
		}
	}
	else if (testType == QH_PIXEL_COLOR) {
		// make test pattern
		for (int x = 0; x < width; x++) {
			for (int y = 0; y < height; y++) {
				if (y <= height / 2 && x <= width / 2) {
					pixel[y * width * 3 + x * 3 + 0] = 255;
					pixel[y * width * 3 + x * 3 + 1] = 0;
					pixel[y * width * 3 + x * 3 + 2] = 0;
				}
				else if (y <= height / 2 && x > width / 2) {
					pixel[y * width * 3 + x * 3 + 0] = 0;
					pixel[y * width * 3 + x * 3 + 1] = 255;
					pixel[y * width * 3 + x * 3 + 2] = 0;
				}
				else if (y > height / 2 && x <= width / 2) {
					pixel[y * width * 3 + x * 3 + 0] = 0;
					pixel[y * width * 3 + x * 3 + 1] = 0;
					pixel[y * width * 3 + x * 3 + 2] = 255;
				}
				else if (y > height / 2 && x > width / 2) {
					pixel[y * width * 3 + x * 3 + 0] = 255;
					pixel[y * width * 3 + x * 3 + 1] = 255;
					pixel[y * width * 3 + x * 3 + 2] = 255;
				}
			}
		}
	}
	else {
		printf("Unsupported test condition.\n");
		assert(0);
	}	
}

void testPixel2CGImage2File2CGImage2Pixel(QH_PIXEL_TYPE testType, QH_TEST_IMAGE_TYPE fileType) {
	// parameter
	int tolerance = 2;
	QH_BYTES_PER_PIXEL bytesPerPixel = QH_BYTES_PER_PIXEL_UNKNOWN;
	
	// original pixel data
	int originalWidth = 32;
	int originalHeight = 32;
	unsigned char* original = NULL;
	
	// alloc test pattern
	if (testType == QH_PIXEL_GRAYSCALE) {
		bytesPerPixel = QH_BYTES_PER_PIXEL_8BIT;
		original = (unsigned char*)malloc(sizeof(unsigned char) * originalWidth * originalHeight * QH_BYTES_PER_PIXEL_8BIT);
	}
	else if (testType == QH_PIXEL_COLOR) {
		bytesPerPixel = QH_BYTES_PER_PIXEL_24BIT;
		original = (unsigned char*)malloc(sizeof(unsigned char) * originalWidth * originalHeight * QH_BYTES_PER_PIXEL_24BIT);
	}
	else {
		printf("Unsupported test condition.\n");
		assert(0);
	}
	
	// copy test pattern
	copyTestPixelPattern(original, originalWidth, originalHeight, testType);
	
	// make CGImage
	CGImageRef image = CGImageCreateWithPixelBuffer(original, originalWidth, originalHeight, bytesPerPixel, testType);
	
	// write CGImage as image file
	NSData *data = nil;
	if (fileType == QH_TEST_JPG) {
		data = CGImageGetJPEGPresentation(image);
	}
	else if (fileType == QH_TEST_PNG) {
		data = CGImageGetPNGPresentation(image);
	}
	else {
		printf("Unsupported test condition.\n");
		assert(0);
	}
	NSString *path = makeFilePathInDocumentFolder(@"tempfile");
	[data writeToFile:path atomically:YES];
	
	// load CGImage from image file
	CGImageRef imageReloaded = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
	
	// load pixel array from CGImage
	int reloadedWidth = 0;
	int reloadedHeight = 0;
	int reloadedBytesPerPixel = 0;
	unsigned char *reloadedPixel = NULL;
	CGCreatePixelBufferWithImage(imageReloaded, &reloadedPixel, &reloadedWidth, &reloadedHeight, &reloadedBytesPerPixel, testType);
	
	assert(compareBuffers(original, reloadedPixel, reloadedWidth * reloadedHeight, tolerance));
	
	free(reloadedPixel);
	CGImageRelease(imageReloaded);
	
	// release memory
	CGImageRelease(image);
	free(original);
	
	printf("testPixel2CGImage2File2CGImage2Pixel OK\n\n");
}

void testPixel2CGImage2Pixel(QH_PIXEL_TYPE testType) {
	// parameter
	int tolerance = 2;
	QH_BYTES_PER_PIXEL bytesPerPixel = QH_BYTES_PER_PIXEL_UNKNOWN;
	
	// original pixel data
	int originalWidth = 32;
	int originalHeight = 32;
	unsigned char* original = NULL;
	
	// alloc test pattern
	if (testType == QH_PIXEL_GRAYSCALE) {
		bytesPerPixel = QH_BYTES_PER_PIXEL_8BIT;
		original = (unsigned char*)malloc(sizeof(unsigned char) * originalWidth * originalHeight * QH_BYTES_PER_PIXEL_8BIT);
	}
	else if (testType == QH_PIXEL_COLOR) {
		bytesPerPixel = QH_BYTES_PER_PIXEL_24BIT;
		original = (unsigned char*)malloc(sizeof(unsigned char) * originalWidth * originalHeight * QH_BYTES_PER_PIXEL_24BIT);
	}
	else {
		printf("Unsupported test condition.\n");
		assert(0);
	}
	
	// copy test pattern
	copyTestPixelPattern(original, originalWidth, originalHeight, testType);
	
	// make CGImage
	CGImageRef image = CGImageCreateWithPixelBuffer(original, originalWidth, originalHeight, bytesPerPixel, testType);
	
	// copy pixel from CGImage
	int copiedWidth = 0;
	int copiedHeight = 0;
	int copiedBytesPerPixel = 0;
	unsigned char *copiedPixel = NULL;
	CGCreatePixelBufferWithImage(image, &copiedPixel, &copiedWidth, &copiedHeight, &copiedBytesPerPixel, testType);
	
	// test
	assert(compareBuffers(original, copiedPixel, originalWidth * originalHeight, tolerance));
	
	// release memory
	CGImageRelease(image);
	free(original);
	
	printf("testPixel2CGImage2Pixel OK\n\n");
}

#pragma mark -
#pragma mark Dump

void testCGImageDump() {
	// test file paths
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
	for (NSString *path in paths) {
		printf("Image file = %s\n", [[path lastPathComponent] UTF8String]);
		CGImageRef imageRef = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
		CGImageDumpImageInformation(imageRef);
		printf("\n");
	}
	printf("testCGImageDump OK\n\n");
}

#pragma mark - Image load test

void imageLoadTest() {
	//
	// test code Image file->CGImage->pixel vs RAW data.
	// only RGB
	//
	// make file path
	NSArray *paths = [NSArray arrayWithObjects:
					  [[NSBundle mainBundle] pathForResource:@"testImage_Gray_PNG24.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_Gray_JPG24.jpg" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_Gray_PNG8.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_Gray_PNG24.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_RGB_JPG24.jpg" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_RGB_PNG8.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_RGB_PNG24.png" ofType:nil],
					  nil];
	for (NSString *path in paths) {
		// file name
		printf("%s\n", [[path lastPathComponent] UTF8String]);
		
		// load grand truth raw data file
		NSString *rawPath = [[path stringByDeletingPathExtension] stringByAppendingPathExtension:@"raw"];
		NSData *data = [NSData dataWithContentsOfFile:rawPath];
		
		// image data
		unsigned char *pixel = NULL;
		int width, height, bytesPerPixel;
		int tolerance = 2;
		
		// load image file as CGImage
		CGImageRef imageRef = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
		
		// copy image to pixel array from CGImage
		CGCreatePixelBufferWithImage(imageRef, &pixel, &width, &height, &bytesPerPixel, QH_PIXEL_COLOR);
		
		// test
		assert(compareBuffersWithXandY(pixel, (unsigned char*)[data bytes], width, height, bytesPerPixel, tolerance));
		
		// release pixel array
		free(pixel);
	}
	printf("imageLoadTest OK\n\n");
}

#pragma mark - Test

void test() {
	testCGImageDump();
	
	testPixel2CGImage2Pixel(QH_PIXEL_COLOR);
	testPixel2CGImage2Pixel(QH_PIXEL_GRAYSCALE);
	
	testPixel2CGImage2File2CGImage2Pixel(QH_PIXEL_COLOR, QH_TEST_JPG);
	testPixel2CGImage2File2CGImage2Pixel(QH_PIXEL_GRAYSCALE, QH_TEST_JPG);
	
	testPixel2CGImage2File2CGImage2Pixel(QH_PIXEL_COLOR, QH_TEST_PNG);
	testPixel2CGImage2File2CGImage2Pixel(QH_PIXEL_GRAYSCALE, QH_TEST_PNG);
	
	imageLoadTest();
	
	testImageOrientation();
}
