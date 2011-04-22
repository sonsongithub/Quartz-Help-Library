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

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Load image file

CGImageRef CGImageCreateWithPNGorJPEGFilePath(CFStringRef filePath);

#pragma mark -
#pragma mark Dump CGImage information

void CGImageDumpImageInformation(CGImageRef imageRef);
void CGImageDumpImageAttribute(CGImageRef imageRef);
void CGImageDumpAlphaInformation(CGImageRef imageRef);
void CGImageDumpBitmapInformation(CGImageRef imageRef);

#pragma mark -
#pragma mark Read pixel from CGImage

void CGImageCreateGrayPixelBuffer(CGImageRef imageRef, unsigned char **pixel, int *width, int *height);
void CGImageCreateRGBPixelBuffer(CGImageRef imageRef, unsigned char **pixel, int *width, int *height);

#pragma mark -
#pragma mark Creating CGImage

CGImageRef CGImageGrayColorCreateWithGrayPixelBuffer(unsigned char *pixel, int width, int height);
CGImageRef CGImageRGBColorCreateWithGrayPixelBuffer(unsigned char *pixel, int width, int height);
CGImageRef CGImageRGBColorCreateWithRGBPixelBuffer(unsigned char *pixel, int width, int height);
CGImageRef CGImageRGBAColorCreateWithRGBPixelBuffer(unsigned char *pixel, int width, int height);

#pragma mark -
#pragma mark Convert CGImage to image file binary

NSData* CGImageGetPNGPresentation(CGImageRef imageRef);
NSData* CGImageGetJPEGPresentation(CGImageRef imageRef);