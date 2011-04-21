//
//  test.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "test.h"

#include "QuartzHelpLibrary.h"

int compareBuffers(unsigned char* b1, unsigned char *b2, int length, int tolerance) {
	for (int i = 0; i < length; i++) {
		if (abs(*(b1 + i) - *(b2 + i)) > tolerance) {
			return 0;	
		}
	}
	return 1;
}

NSString* makeFilePathInDocumentFolder(NSString *filename) {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:filename];
}

void testCGImageGrayBufferReadAndWrite() {
	printf("\ngray pixel array convert test\n");
	// original pixel data
	int originalWidth = 32;
	int originalHeight = 32;
	unsigned char* original = (unsigned char*)malloc(sizeof(unsigned char) * originalWidth * originalHeight);
	
	// make test pattern
	for (int x = 0; x < originalWidth; x++) {
		for (int y = 0; y < originalHeight; y++) {
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
		printf("\ntest case1\n");
		printf("pixel(Gray) -> CGImage(Gray) -> write image file -> load image file-> CGImage(RGBA) -> pixel(Gray)\n");

		CGImageRef image = CGImageGrayColorCreateWithGrayPixelBuffer(original, originalWidth, originalHeight);
		
		int copiedWidth = 0;
		int copiedHeight = 0;
		unsigned char *copiedPixel = NULL;
		
		CGImageCreateGrayPixelBuffer(image, &copiedPixel, &copiedWidth, &copiedHeight);
		
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
			
			CGImageCreateGrayPixelBuffer(imageReloaded, &reloadedPixel, &reloadedWidth, &reloadedHeight);
			
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
			
			CGImageCreateGrayPixelBuffer(imageReloaded, &reloadedPixel, &reloadedWidth, &reloadedHeight);
			
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
		printf("pixel(Gray) -> CGImage(RGB) -> write image file -> load image file -> CGImage(RGBA) -> pixel(Gray)\n");
		
		CGImageRef image = CGImageCreateWithGrayPixelBuffer(original, originalWidth, originalHeight);
		
		int copiedWidth = 0;
		int copiedHeight = 0;
		unsigned char *copiedPixel = NULL;
		
		CGImageCreateGrayPixelBuffer(image, &copiedPixel, &copiedWidth, &copiedHeight);
		
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
			
			CGImageCreateGrayPixelBuffer(imageReloaded, &reloadedPixel, &reloadedWidth, &reloadedHeight);
			
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
			
			CGImageCreateGrayPixelBuffer(imageReloaded, &reloadedPixel, &reloadedWidth, &reloadedHeight);
			
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

void testImage(NSString *path) {
	CGImageRef imageRef = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
	CGImageDumpImageInformation(imageRef);
	CGImageDumpAlphaInformation(imageRef);
	CGImageDumpBitmapInformation(imageRef);
}

void test() {
	NSArray *paths = [NSArray arrayWithObjects:
										[[NSBundle mainBundle] pathForResource:@"iossdkhack" ofType:@"jpg"],
										[[NSBundle mainBundle] pathForResource:@"iossdkhack" ofType:@"png"],
										nil];
	for (NSString *path in paths) {
		NSLog(@"%@", path);
		testImage(path);
	}
	
	
	testCGImageGrayBufferReadAndWrite();
}
