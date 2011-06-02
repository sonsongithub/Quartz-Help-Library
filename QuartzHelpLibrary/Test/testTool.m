/*
 * Quartz Help Library
 * testTool.m
 *
 * Copyright (c) Yuichi YOSHIDA, 11/06/01
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

