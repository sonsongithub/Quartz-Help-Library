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

#pragma mark -
#pragma mark help tool

int compareBuffers(unsigned char* b1, unsigned char *b2, int length, int tolerance) {
	for (int i = 0; i < length; i++) {
		if (abs(*(b1 + i) - *(b2 + i)) > tolerance) {
			return 0;	
		}
	}
	return 1;
}

void dumpRGBPixelArray(unsigned char *pixel, int width, int height) {
	// make test pattern
	for (int y = 0; y < height; y++) {
		for (int x = 0; x < width; x++) {
			printf("%02x%02x%02x ", pixel[y * width * 3 + x * 3 + 0], pixel[y * width * 3 + x * 3 + 1], pixel[y * width * 3 + x * 3 + 2]);
		}
		printf("\n");
	}
}

void dumpPixelArray(unsigned char *pixel, int width, int height, int bytesPerPixel) {
	// make test pattern
	for (int y = 0; y < height; y++) {
		for (int x = 0; x < width; x++) {
			for (int i = 0; i < bytesPerPixel; i++) {
				printf("%02x", pixel[y * width * bytesPerPixel + x * bytesPerPixel + i]);
			}
			printf(" ");
		}
		printf("\n");
	}
}

NSString* makeFilePathInDocumentFolder(NSString *filename) {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:filename];
}

#pragma mark -
#pragma mark CGImage and image file

void testCGImageRGBBufferReadAndWrite() {
	printf("\n---------->testCGImageRGBBufferReadAndWrite\n");
	printf("void CGCreatePixelBufferWithImage(CGImageRef imageRef, unsigned char **pixel, int *width, int *height);\n");
	printf("CGImageRef CGImageRGBColorCreateWithRGBPixelBuffer(unsigned char *pixel, int width, int height);\n");
	printf("CGImageRef CGImageRGBAColorCreateWithRGBAPixelBuffer(unsigned char *pixel, int width, int height);\n");
	printf("\n");
	
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
	
	// test case 1
	{
		printf("test case1\n");
		
		CGImageRef image = CGImageRGBColorCreateWithRGBPixelBuffer(original, originalWidth, originalHeight);
		
		int copiedWidth = 0;
		int copiedHeight = 0;
		int copiedBytesPerPixel = 0;
		unsigned char *copiedPixel = NULL;
		
		CGCreatePixelBufferWithImage(image, &copiedPixel, &copiedWidth, &copiedHeight, &copiedBytesPerPixel, QH_PIXEL_COLOR);
		
		int tolerance = 0;
		
		printf("pixel(RGB)->CGImage(RGB)->pixel(RGB)\n");
		
		if (compareBuffers(original, copiedPixel, originalWidth * originalHeight, tolerance))
			printf("=>OK (tolerance=%d)\n", tolerance);
		else
			printf("=>Error\n");
		
		{
			NSData *data = CGImageGetPNGPresentation(image);
			NSString *path = makeFilePathInDocumentFolder(@"rgbcase1.png");
			[data writeToFile:path atomically:YES];
			
			CGImageRef imageReloaded = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
			
			int reloadedWidth = 0;
			int reloadedHeight = 0;
			int reloadedBytesPerPixel = 0;
			unsigned char *reloadedPixel = NULL;
			
			CGCreatePixelBufferWithImage(imageReloaded, &reloadedPixel, &reloadedWidth, &reloadedHeight, &reloadedBytesPerPixel, QH_PIXEL_COLOR);
			
			int reloadedTolerance = 2;
			
			printf("pixel(RGB)->CGImage(RGB)->PNG file(RGB)->CGImage(RGBA)->pixel(RGB)\n");
			
			if (compareBuffers(original, copiedPixel, originalWidth * originalHeight, reloadedTolerance))
				printf("=>OK (tolerance=%d)\n", reloadedTolerance);
			else
				printf("=>Error\n");
		}
		
		{
			NSData *data = CGImageGetJPEGPresentation(image);
			NSString *path = makeFilePathInDocumentFolder(@"rgbcase1.jpg");
			[data writeToFile:path atomically:YES];
			
			CGImageRef imageReloaded = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
			
			int reloadedWidth = 0;
			int reloadedHeight = 0;
			int reloadedBytesPerPixel = 0;
			unsigned char *reloadedPixel = NULL;
			
			CGCreatePixelBufferWithImage(imageReloaded, &reloadedPixel, &reloadedWidth, &reloadedHeight, &reloadedBytesPerPixel, QH_PIXEL_COLOR);
			
			int reloadedTolerance = 2;
			
			printf("pixel(RGB)->CGImage(RGB)->JPG file(RGB)->CGImage(RGBA)->pixel(RGB)\n");
			
			if (compareBuffers(original, copiedPixel, originalWidth * originalHeight, reloadedTolerance))
				printf("=>OK (tolerance=%d)\n", reloadedTolerance);
			else
				printf("=>Error\n");
		}
	}
	
	// test case 2
	{
		printf("\ntest case2\n");
		
		CGImageRef image = CGImageRGBAColorCreateWithRGBPixelBuffer(original, originalWidth, originalHeight);
		
		int copiedWidth = 0;
		int copiedHeight = 0;
		int copiedBytesPerPixel = 0;
		unsigned char *copiedPixel = NULL;
		
		CGCreatePixelBufferWithImage(image, &copiedPixel, &copiedWidth, &copiedHeight, &copiedBytesPerPixel, QH_PIXEL_COLOR);
		
		int tolerance = 0;
		
		printf("pixel(RGB)->CGImage(RGBA)->pixel(RGB)\n");
		
		if (compareBuffers(original, copiedPixel, originalWidth * originalHeight, tolerance))
			printf("=>OK (tolerance=%d)\n", tolerance);
		else
			printf("=>Error\n");
		
		{
			NSData *data = CGImageGetPNGPresentation(image);
			NSString *path = makeFilePathInDocumentFolder(@"rgbcase2.png");
			[data writeToFile:path atomically:YES];
			
			CGImageRef imageReloaded = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
			
			int reloadedWidth = 0;
			int reloadedHeight = 0;
			int reloadedBytesPerPixel = 0;
			unsigned char *reloadedPixel = NULL;
			
			CGCreatePixelBufferWithImage(imageReloaded, &reloadedPixel, &reloadedWidth, &reloadedHeight, &reloadedBytesPerPixel, QH_PIXEL_COLOR);
			
			int reloadedTolerance = 2;
			
			printf("pixel(RGB)->CGImage(RGBA)->PNG file(RGBA)->CGImage(RGBA)->pixel(RGB)\n");
			
			if (compareBuffers(original, copiedPixel, originalWidth * originalHeight, reloadedTolerance))
				printf("=>OK (tolerance=%d)\n", reloadedTolerance);
			else
				printf("=>Error\n");
		}
		
		{
			NSData *data = CGImageGetJPEGPresentation(image);
			NSString *path = makeFilePathInDocumentFolder(@"rgbcase2.jpg");
			[data writeToFile:path atomically:YES];
			
			CGImageRef imageReloaded = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
			
			int reloadedWidth = 0;
			int reloadedHeight = 0;
			int reloadedBytesPerPixel = 0;
			unsigned char *reloadedPixel = NULL;
			
			CGCreatePixelBufferWithImage(imageReloaded, &reloadedPixel, &reloadedWidth, &reloadedHeight, &reloadedBytesPerPixel, QH_PIXEL_COLOR);
			
			int reloadedTolerance = 2;
			
			printf("pixel(RGB)->CGImage(RGBA)->JPG file(RGB)->CGImage(RGBA)->pixel(RGB)\n");
			
			if (compareBuffers(original, copiedPixel, originalWidth * originalHeight, reloadedTolerance))
				printf("=>OK (tolerance=%d)\n", reloadedTolerance);
			else
				printf("=>Error\n");
		}
	}
}

void testCGImageGrayBufferReadAndWrite() {
	printf("\n---------->testCGImageGrayBufferReadAndWrite\n");
	printf("void CGCreateGrayPixelBufferWithImage(CGImageRef imageRef, unsigned char **pixel, int *width, int *height);\n");
	printf("CGImageRef CGImageGrayColorCreateWithGrayPixelBuffer(unsigned char *pixel, int width, int height);\n");
	printf("CGImageRef CGImageRGBColorCreateWithGrayPixelBuffer(unsigned char *pixel, int width, int height);\n");
	printf("\n");
	
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
	
	// test case 1
	{
		printf("test case1\n");

		CGImageRef image = CGImageGrayColorCreateWithGrayPixelBuffer(original, originalWidth, originalHeight);
		
		int copiedWidth = 0;
		int copiedHeight = 0;
		int copiedBytesPerPixel = 0;
		unsigned char *copiedPixel = NULL;
		
//		CGCreateGrayPixelBufferWithImage(image, &copiedPixel, &copiedWidth, &copiedHeight);
		CGCreatePixelBufferWithImage(image, &copiedPixel, &copiedWidth, &copiedHeight, &copiedBytesPerPixel, QH_PIXEL_GRAYSCALE);
		
		dumpPixelArray(copiedPixel, copiedWidth, copiedHeight, copiedBytesPerPixel);
		
		int tolerance = 0;
		
		printf("pixel(Gray)->CGImage(Gray)->pixel(Gray)\n");
		
		if (compareBuffers(original, copiedPixel, originalWidth * originalHeight, tolerance))
			printf("=>OK (tolerance=%d)\n", tolerance);
		else
			printf("=>Error\n");
		
		{
			NSData *data = CGImageGetPNGPresentation(image);
			NSString *path = makeFilePathInDocumentFolder(@"case1.png");
			[data writeToFile:path atomically:YES];
			
			CGImageRef imageReloaded = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
			
			int reloadedWidth = 0;
			int reloadedHeight = 0;
			unsigned char *reloadedPixel = NULL;
			
			CGCreateGrayPixelBufferWithImage(imageReloaded, &reloadedPixel, &reloadedWidth, &reloadedHeight);
			
			int reloadedTolerance = 2;
			
			printf("pixel(Gray)->CGImage(Gray)->PNG file(Gray)->CGImage(RGBA)->pixel(Gray)\n");
			
			if (compareBuffers(original, copiedPixel, originalWidth * originalHeight, reloadedTolerance))
				printf("=>OK (tolerance=%d)\n", reloadedTolerance);
			else
				printf("=>Error\n");
		}
		
		{
			NSData *data = CGImageGetJPEGPresentation(image);
			NSString *path = makeFilePathInDocumentFolder(@"case1.jpg");
			[data writeToFile:path atomically:YES];
			
			CGImageRef imageReloaded = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
			
			int reloadedWidth = 0;
			int reloadedHeight = 0;
			unsigned char *reloadedPixel = NULL;
			
			CGCreateGrayPixelBufferWithImage(imageReloaded, &reloadedPixel, &reloadedWidth, &reloadedHeight);
			
			int reloadedTolerance = 2;
			
			printf("pixel(Gray)->CGImage(Gray)->JPG file(Gray)->CGImage(RGBA)->pixel(Gray)\n");
			
			if (compareBuffers(original, copiedPixel, originalWidth * originalHeight, reloadedTolerance))
				printf("=>OK (tolerance=%d)\n", reloadedTolerance);
			else
				printf("=>Error\n");
		}
		
		CGImageRelease(image);
		
	}
	
	// test case 2
	{
		printf("\ntest case2\n");
		
		CGImageRef image = CGImageRGBColorCreateWithGrayPixelBuffer(original, originalWidth, originalHeight);
		
		int copiedWidth = 0;
		int copiedHeight = 0;
		unsigned char *copiedPixel = NULL;
		
		CGCreateGrayPixelBufferWithImage(image, &copiedPixel, &copiedWidth, &copiedHeight);
		
		int tolerance = 2;
		
		printf("pixel(Gray)->CGImage(RGB)->pixel(Gray)\n");
			   
		if (compareBuffers(original, copiedPixel, originalWidth * originalHeight, tolerance))
			printf("=>OK (tolerance=%d)\n", tolerance);
		else
			printf("=>Error\n");
		
		{
			NSData *data = CGImageGetPNGPresentation(image);
			NSString *path = makeFilePathInDocumentFolder(@"case2.png");
			[data writeToFile:path atomically:YES];
			
			CGImageRef imageReloaded = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
			
			int reloadedWidth = 0;
			int reloadedHeight = 0;
			unsigned char *reloadedPixel = NULL;
			
			int reloadedTolerance = 2;
			
			CGCreateGrayPixelBufferWithImage(imageReloaded, &reloadedPixel, &reloadedWidth, &reloadedHeight);
			
			printf("pixel(Gray)->CGImage(RGB)->PNG file(RGB)->CGImage(RGBA)->pixel(Gray)\n");
			
			if (compareBuffers(original, copiedPixel, originalWidth * originalHeight, reloadedTolerance))
				printf("=>OK (tolerance=%d)\n", reloadedTolerance);
			else
				printf("=>Error\n");
		}
		
		{
			NSData *data = CGImageGetJPEGPresentation(image);
			NSString *path = makeFilePathInDocumentFolder(@"case2.jpg");
			[data writeToFile:path atomically:YES];
			
			CGImageRef imageReloaded = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
			
			int reloadedWidth = 0;
			int reloadedHeight = 0;
			unsigned char *reloadedPixel = NULL;
			
			int reloadedTolerance = 2;
			
			CGCreateGrayPixelBufferWithImage(imageReloaded, &reloadedPixel, &reloadedWidth, &reloadedHeight);
			
			printf("pixel(Gray)->CGImage(RGB)->JPG file(RGB)->CGImage(RGBA)->pixel(Gray)\n");
			
			if (compareBuffers(original, copiedPixel, originalWidth * originalHeight, reloadedTolerance))
				printf("=>OK (tolerance=%d)\n", reloadedTolerance);
			else
				printf("=>Error\n");
		}
		
		
		CGImageRelease(image);
	}
	
	free(original);
}

#pragma mark -
#pragma mark dump

void testCGImageDump() {
	printf("\n---------->test\n");
	printf("void CGImageDumpImageInformation(CGImageRef imageRef);\n");
	printf("void CGImageDumpImageAttribute(CGImageRef imageRef);\n");
	printf("void CGImageDumpAlphaInformation(CGImageRef imageRef);\n");
	printf("void CGImageDumpBitmapInformation(CGImageRef imageRef);\n");
	printf("\n");

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
}

#pragma mark - Image load test

void imageGrayColorLoadTest() {
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
	for (NSString *path in paths) {
		unsigned char *pixel = NULL;
		int width, height, bytesPerPixel;
		printf("\nImage file = %s\n", [[path lastPathComponent] UTF8String]);
		CGImageRef imageRef = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
		CGImageDumpImageInformation(imageRef);
		
		CGCreatePixelBufferWithImage(imageRef, &pixel, &width, &height, &bytesPerPixel, QH_PIXEL_GRAYSCALE);
		dumpPixelArray(pixel, width, height, bytesPerPixel);
		free(pixel);
		
		CGCreatePixelBufferWithImage(imageRef, &pixel, &width, &height, &bytesPerPixel, QH_PIXEL_COLOR);
		dumpPixelArray(pixel, width, height, bytesPerPixel);
		free(pixel);
		
		CGCreatePixelBufferWithImage(imageRef, &pixel, &width, &height, &bytesPerPixel, QH_PIXEL_ANYCOLOR);
		dumpPixelArray(pixel, width, height, bytesPerPixel);
		free(pixel);
	}
}

void imageLoadTest() {
	imageGrayColorLoadTest();
}

#pragma mark - test

void test() {
	testCGImageDump();
	testCGImageGrayBufferReadAndWrite();
	testCGImageRGBBufferReadAndWrite();
}
