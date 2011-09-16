/*
 * Quartz Help Library
 * QuartzHelpLibrary.h
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

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#pragma mark - Invaliables

typedef enum {
	QH_PIXEL_GRAYSCALE =			0,
	QH_PIXEL_COLOR =				1 << 0,
	QH_PIXEL_ANYCOLOR =				1 << 1,
}QH_PIXEL_TYPE;

typedef enum {
	QH_BYTES_PER_PIXEL_UNKNOWN =	0,
	QH_BYTES_PER_PIXEL_8BIT =		1,
	QH_BYTES_PER_PIXEL_16BIT =		2,
	QH_BYTES_PER_PIXEL_24BIT =		3,
	QH_BYTES_PER_PIXEL_32BIT =		4,
}QH_BYTES_PER_PIXEL;

#define QH_DEFAULT_ALPHA_VALUE		0xff

#define QH_DEFAULT_JPG_QUALITY		1.0

#pragma mark - UIImage category

@interface UIImage(QuartzHelpLibrary)
- (NSData*)PNGRepresentaion;
- (NSData*)JPEGRepresentaion;
- (NSData*)JPEGRepresentaionWithCompressionQuality:(float)compressionQuality;
- (UIImage*)getRotatedImage;
- (UIImage*)getRotatedImageWithResizing:(float)scale;
- (CGImageRef)createCGImageRotated;
- (CGImageRef)createCGImageRotatedWithResizing:(float)scale;
@end

#ifdef __cplusplus
extern "C" {
#endif

#pragma mark - Load image file

CGImageRef CGImageCreateWithPNGorJPEGFilePath(CFStringRef filePath);

#pragma mark - Dump CGImage information

void CGImageDumpImageInformation(CGImageRef imageRef);

#pragma mark - Read pixel from CGImage

void CGCreatePixelBufferWithImage(CGImageRef imageRef, unsigned char **pixel, int *width, int *height, int *bytesPerPixel, QH_PIXEL_TYPE pType);

#pragma mark - Creating CGImage

CGImageRef CGImageCreateWithPixelBuffer(unsigned char *pixel, int width, int height, int bytesPerPixel, QH_PIXEL_TYPE target_pType);

#pragma mark - Convert CGImage to image file binary

NSData* CGImageGetPNGPresentation(CGImageRef imageRef);
NSData* CGImageGetJPEGPresentation(CGImageRef imageRef);

#pragma mark - Resize

CGImageRef CGImageCreateWithResizing(CGImageRef imageRef, float scale);
	
#ifdef __cplusplus
}
#endif