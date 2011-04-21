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

typedef enum {
	ReadImage8bit,
	ReadImage16bitSkipLast,
	ReadImage16bitSkipFirst,
	ReadImage24bit,
	ReadImage32bitSkipLast,
	ReadImage32bitSkipFirst,
}ReadImageType;

void CGImageCreateGrayPixelBuffer(CGImageRef imageRef, unsigned char **pixel, int *width, int *height) {
	*pixel = NULL;
	*width = 0;
	*height = 0;
	
	int inputImageWidth = CGImageGetWidth(imageRef);
	int inputImageHeight = CGImageGetHeight(imageRef);
	
	size_t bitsPerPixel_imageRef = CGImageGetBitsPerPixel(imageRef);
	size_t bytesPerRow_imageRef = CGImageGetBytesPerRow(imageRef);
	size_t bytesPerPixel = bitsPerPixel_imageRef / 8;
	CGImageAlphaInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
	CGImageAlphaInfo bitmapAlphaInfo = bitmapInfo & kCGBitmapAlphaInfoMask;
	bitmapInfo = bitmapInfo & kCGBitmapByteOrderMask;
	
	ReadImageType readImageType = ReadImage24bit;
	
	if (bytesPerPixel > 4 || bitmapInfo == kCGBitmapFloatComponents)
		return;
	
	if (bytesPerPixel == 1) {
		readImageType = ReadImage8bit;
	}
	else if (bytesPerPixel == 2 && (bitmapAlphaInfo == kCGImageAlphaPremultipliedFirst || bitmapAlphaInfo == kCGImageAlphaFirst || bitmapAlphaInfo == kCGImageAlphaNoneSkipFirst)) {
		readImageType = ReadImage16bitSkipFirst;
	}
	else if (bytesPerPixel == 2 && (bitmapAlphaInfo == kCGImageAlphaPremultipliedLast || bitmapAlphaInfo == kCGImageAlphaLast || bitmapAlphaInfo == kCGImageAlphaNoneSkipLast)) {
		readImageType = ReadImage16bitSkipLast;
	}
	else if (bytesPerPixel == 3) {
		readImageType = ReadImage24bit;
	}
	else if (bytesPerPixel == 4 && (bitmapAlphaInfo == kCGImageAlphaPremultipliedFirst || bitmapAlphaInfo == kCGImageAlphaFirst || bitmapAlphaInfo == kCGImageAlphaNoneSkipFirst)) {
		readImageType = ReadImage32bitSkipFirst;
	}
	else if (bytesPerPixel == 4 && (bitmapAlphaInfo == kCGImageAlphaPremultipliedLast || bitmapAlphaInfo == kCGImageAlphaLast || bitmapAlphaInfo == kCGImageAlphaNoneSkipLast)) {
		readImageType = ReadImage32bitSkipLast;
	}
	else {
		return;
	}
	
	CGDataProviderRef inputImageProvider = CGImageGetDataProvider(imageRef);
	
	CFDataRef data = CGDataProviderCopyData(inputImageProvider);
	
	unsigned char *pixelData = (unsigned char *) CFDataGetBytePtr(data);
	
	unsigned char *output = (unsigned char*)malloc(sizeof(unsigned char) * inputImageWidth * inputImageHeight);
	
	if (readImageType == ReadImage8bit) {
		for (int y = 0; y < inputImageHeight; y++) {
			for (int x = 0; x < inputImageWidth; x++) {
				int offset = y * bytesPerRow_imageRef + x * bytesPerPixel;
				output[y * inputImageWidth + x] = pixelData[offset];
			}
		}
	}
	else if (readImageType == ReadImage16bitSkipFirst) {
		for (int y = 0; y < inputImageHeight; y++) {
			for (int x = 0; x < inputImageWidth; x++) {
				int offset = y * bytesPerRow_imageRef + x * bytesPerPixel;
				output[y * inputImageWidth + x] = pixelData[offset + 1];
			}
		}
	}
	else if (readImageType == ReadImage16bitSkipLast) {
		for (int y = 0; y < inputImageHeight; y++) {
			for (int x = 0; x < inputImageWidth; x++) {
				int offset = y * bytesPerRow_imageRef + x * bytesPerPixel;
				output[y * inputImageWidth + x] = pixelData[offset + 0];
			}
		}
	}
	else if (readImageType == ReadImage24bit) {
		for (int y = 0; y < inputImageHeight; y++) {
			for (int x = 0; x < inputImageWidth; x++) {
				int offset = y * bytesPerRow_imageRef + x * bytesPerPixel;
				int k = (pixelData[offset + 0]>>2)
					  + (pixelData[offset + 1]>>1)
					  + (pixelData[offset + 2]>>2);
				output[y * inputImageWidth + x] = k;
			}
		}
	}
	else if (readImageType == ReadImage32bitSkipFirst) {
		for (int y = 0; y < inputImageHeight; y++) {
			for (int x = 0; x < inputImageWidth; x++) {
				int offset = y * bytesPerRow_imageRef + x * bytesPerPixel;
				int k = (pixelData[offset + 1]>>2)
				+ (pixelData[offset + 2]>>1)
				+ (pixelData[offset + 3]>>2);
				output[y * inputImageWidth + x] = k;
			}
		}
	}
	else if (readImageType == ReadImage32bitSkipLast) {
		for (int y = 0; y < inputImageHeight; y++) {
			for (int x = 0; x < inputImageWidth; x++) {
				int offset = y * bytesPerRow_imageRef + x * bytesPerPixel;
				int k = (pixelData[offset + 0]>>2)
				+ (pixelData[offset + 1]>>1)
				+ (pixelData[offset + 2]>>2);
				output[y * inputImageWidth + x] = k;
			}
		}
	}
	
	// output
	*pixel = output;
	*width = inputImageWidth;
	*height = inputImageHeight;
	
	CFRelease(data);
}

CGImageRef CGImageGrayColorCreateWithGrayPixelBuffer(unsigned char *pixel, int width, int height) {
	CGColorSpaceRef grayColorSpace = CGColorSpaceCreateDeviceGray();
	CGContextRef context = CGBitmapContextCreate(pixel, width, height, 8, width, grayColorSpace, kCGImageAlphaNone);
	CGImageRef image = CGBitmapContextCreateImage(context);
	CGColorSpaceRelease(grayColorSpace);
	return image;
}

CGImageRef CGImageCreateWithGrayPixelBuffer(unsigned char *pixel, int width, int height) {
	CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
	
	unsigned char *rgbPixel = (unsigned char*)malloc(sizeof(unsigned char) * width * height * 4);
	
	for (int y = 0; y < height; y++) {
		for (int x = 0; x < width; x++) {
			rgbPixel[y * width * 4 + 4 * x + 0] = pixel[y * width + x + 0];
			rgbPixel[y * width * 4 + 4 * x + 1] = pixel[y * width + x + 0];
			rgbPixel[y * width * 4 + 4 * x + 2] = pixel[y * width + x + 0];
			rgbPixel[y * width * 4 + 4 * x + 3] = 255;
		}
	}
	
	CGContextRef context = CGBitmapContextCreate(rgbPixel, width, height, 8, width * 4, rgbColorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);

	CGImageRef image = CGBitmapContextCreateImage(context);
	CGColorSpaceRelease(rgbColorSpace);
	free(rgbPixel);
	return image;
}