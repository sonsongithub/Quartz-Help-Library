//
//  testTool.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/05/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "testTool.h"

#pragma mark - help tool

int compareBuffers(unsigned char* b1, unsigned char *b2, int length, int tolerance) {
	for (int i = 0; i < length; i++) {
		if (abs(*(b1 + i) - *(b2 + i)) > tolerance) {
			printf("diff = %d (%02X) (%02X)\n", *(b1 + i) - *(b2 + i), *(b1 + i), *(b2 + i));
			return 0;	
		}
	}
	return 1;
}

int compareBuffersWithXandY(unsigned char* b1, unsigned char *b2, int width, int height, int bytesPerPixel, int tolerance) {
	for (int y = 0; y < height; y++) {
		for (int x = 0; x < width; x++) {
			for (int i = 0; i < bytesPerPixel; i++) {
				int offset = (y * width + x) * bytesPerPixel + i;
				unsigned char v1 = *(b1 + offset);
				unsigned char v2 = *(b2 + offset);
				if (abs(v1 - v2) > tolerance) {
					printf("%d,%d(%d)....%02x vs %02x\n", x, y, i, v1, v2);	
					return 0;
				}
			}
		}
	}
	return 1;
}

void dumpPixel(unsigned char *pixel, int width, int height, int bytesPerPixel, int x, int y) {
	for (int i = 0; i < bytesPerPixel; i++) {
		int offset = (y * width + x) * bytesPerPixel + i;
		printf("%02x", pixel[offset]);
	}
	printf("\n");
}

void dumpPixelArray(unsigned char *pixel, int width, int height, int bytesPerPixel, DUMP_PIXEL_FORMAT type) {
	// make test pattern
	if (type == DUMP_PIXEL_HEX) {
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
	else {
		for (int y = 0; y < height; y++) {
			for (int x = 0; x < width/2; x++) {
				for (int i = 0; i < bytesPerPixel; i++) {
					printf("%03d", pixel[y * width * bytesPerPixel + x * bytesPerPixel + i]);
				}
				printf(" ");
			}
			printf("\n");
		}
	}
}

NSString* makeFilePathInDocumentFolder(NSString *filename) {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:filename];
}

