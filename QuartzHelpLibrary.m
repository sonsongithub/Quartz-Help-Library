//
//  QuartzHelpLibrary.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuartzHelpLibrary.h"

CGImageRef CGImageCreateWithPNGorJPEGFilePath(CFStringRef filePath) {
	CGImageRef outputImage = NULL;
	
	CGDataProviderRef providerRef = CGDataProviderCreateWithFilename([(NSString*)filePath UTF8String]);
	
	if (outputImage == NULL)
		outputImage = CGImageCreateWithPNGDataProvider(providerRef, NULL, NO, 0);
	
	if (outputImage == NULL)
		outputImage = CGImageCreateWithJPEGDataProvider(providerRef, NULL, NO, 0);
	
	CGDataProviderRelease(providerRef);
	
	return outputImage;
}

void CGImageDumpImageInformation(CGImageRef imageRef) {
	size_t width = CGImageGetWidth(imageRef);
	size_t height = CGImageGetHeight(imageRef);
	size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
	size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
	size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
	
	printf("width  = %d\n", (int)width);
	printf("height = %d\n", (int)height);
	printf("bits per component = %d\n", (int)bitsPerComponent);
	printf("bits per pixel     = %d\n", (int)bitsPerPixel);
	printf("bytes per pixel    = %d\n", (int)bitsPerPixel/8);
	printf("bytes per row      = %d\n", (int)bytesPerRow);
}

void CGImageDumpAlphaInformation(CGImageRef imageRef) {
	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
	// alpha information
	switch(alphaInfo) {
		case kCGImageAlphaNone:
			printf("Alpha Info = kCGImageAlphaNone\n");
			break;
		case kCGImageAlphaPremultipliedLast:
			printf("Alpha Info = kCGImageAlphaPremultipliedLast\n");
			break;
		case kCGImageAlphaPremultipliedFirst:
			printf("Alpha Info = kCGImageAlphaPremultipliedFirst\n");
			break;
		case kCGImageAlphaLast:
			printf("Alpha Info = kCGImageAlphaLast\n");
			break;
		case kCGImageAlphaFirst:
			printf("Alpha Info = kCGImageAlphaFirst\n");
			break;
		case kCGImageAlphaNoneSkipLast:
			printf("Alpha Info = kCGImageAlphaNoneSkipLast\n");
			break;
		case kCGImageAlphaNoneSkipFirst:
			printf("Alpha Info = kCGImageAlphaNoneSkipFirst\n");
			break;
		default:
			printf("Alpha Info = Error unknown\n");
			break;
	}
}

void CGImageDumpBitmapInformation(CGImageRef imageRef) {
	CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
	CGBitmapInfo byteOrderInfo = (bitmapInfo & kCGBitmapByteOrderMask);
	
	// special case
	if (bitmapInfo == kCGBitmapFloatComponents) {
		printf("Bitmap Info = kCGBitmapFloatComponents\n");
		printf("Alpha Info = ?\n");
		return;
	}
	
	// bitmap information
	switch(byteOrderInfo) {
		case kCGBitmapByteOrderMask:
			printf("Bitmap Info = kCGBitmapByteOrderMask\n");
			break;
		case kCGBitmapByteOrderDefault:
			printf("Bitmap Info = kCGBitmapByteOrderDefault\n");
			break;
		case kCGBitmapByteOrder16Little:
			printf("Bitmap Info = kCGBitmapByteOrder16Little\n");
			break;
		case kCGBitmapByteOrder32Little:
			printf("Bitmap Info = kCGBitmapByteOrder32Little\n");
			break;
		case kCGBitmapByteOrder16Big:
			printf("Bitmap Info = kCGBitmapByteOrder16Big\n");
			break;
		case kCGBitmapByteOrder32Big:
			printf("Bitmap Info = kCGBitmapByteOrder32Big\n");
			break;
		default:
			printf("Bitmap Info = Error unknown\n");
			break;
	}
}
