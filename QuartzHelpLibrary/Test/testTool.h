//
//  testTool.h
//  QuartzHelpLibrary
//
//  Created by sonson on 11/05/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	DUMP_PIXEL_HEX = 0,
	DUMP_PIXEL_DEC = 1
}DUMP_PIXEL_FORMAT;

int compareBuffers(unsigned char* b1, unsigned char *b2, int length, int tolerance);
int compareBuffersWithXandY(unsigned char* b1, unsigned char *b2, int width, int height, int bytesPerPixel, int tolerance);
void dumpPixel(unsigned char *pixel, int width, int height, int bytesPerPixel, int x, int y);
void dumpPixelArray(unsigned char *pixel, int width, int height, int bytesPerPixel, DUMP_PIXEL_FORMAT type);
NSString* makeFilePathInDocumentFolder(NSString *filename);