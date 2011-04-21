//
//  QuartzHelpLibrary.h
//  QuartzHelpLibrary
//
//  Created by sonson on 11/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

CGImageRef CGImageCreateWithPNGorJPEGFilePath(CFStringRef filePath);
void CGImageDumpAlphaInformation(CGImageRef imageRef);
void CGImageDumpBitmapInformation(CGImageRef imageRef);
void CGImageDumpImageInformation(CGImageRef imageRef);

void CGImageCreateGrayPixelBuffer(CGImageRef imageRef, unsigned char **pixel, int *width, int *height);
CGImageRef CGImageGrayColorCreateWithGrayPixelBuffer(unsigned char *pixel, int width, int height);
CGImageRef CGImageCreateWithGrayPixelBuffer(unsigned char *pixel, int width, int height);

NSData* CGImageGetPNGPresentation(CGImageRef imageRef);