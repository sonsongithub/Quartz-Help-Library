//
//  testImageOrientation.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/05/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "testImageOrientation.h"

void makeImage(unsigned char **pixel, int *width, int *height, int *bytesPerPixel, UIImageOrientation orientation) {
	int defaultWidth = QH_ORIENTATION_TEST_WIDTH;
	int defaultHeight = QH_ORIENTATION_TEST_HEIGHT;
	int defaultBytesPerPixel = QH_ORIENTATION_TEST_BYTES_PER_PIXEL;
	
	switch(orientation) {
		case UIImageOrientationUp:
			*width = defaultWidth;
			*height = defaultHeight;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				for (int y = 0; y < (*height); y++) {
					if (y < (*height) / 2 && x < (*width) / 2) {
						(*pixel)[y * (*width) * 3 + x * 3 + 0] = 255;
						(*pixel)[y * (*width) * 3 + x * 3 + 1] = 0;
						(*pixel)[y * (*width) * 3 + x * 3 + 2] = 0;
					}
					else if (y <= (*height) / 2 && x >= (*width) / 2) {
						(*pixel)[y * (*width) * 3 + x * 3 + 0] = 0;
						(*pixel)[y * (*width) * 3 + x * 3 + 1] = 255;
						(*pixel)[y * (*width) * 3 + x * 3 + 2] = 0;
					}
					else if (y >= (*height) / 2 && x < (*width) / 2) {
						(*pixel)[y * (*width) * 3 + x * 3 + 0] = 0;
						(*pixel)[y * (*width) * 3 + x * 3 + 1] = 0;
						(*pixel)[y * (*width) * 3 + x * 3 + 2] = 255;
					}
					else if (y >= (*height) / 2 && x >= (*width) / 2) {
						(*pixel)[y * (*width) * 3 + x * 3 + 0] = 200;
						(*pixel)[y * (*width) * 3 + x * 3 + 1] = 200;
						(*pixel)[y * (*width) * 3 + x * 3 + 2] = 200;
					}
				}
			}
			break;
		case UIImageOrientationDown:
			*width = defaultWidth;
			*height = defaultHeight;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				for (int y = 0; y < (*height); y++) {
					if (y < (*height) / 2 && x < (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 255;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 0;
					}
					else if (y <= (*height) / 2 && x >= (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 255;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 0;
					}
					else if (y >= (*height) / 2 && x < (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 255;
					}
					else if (y >= (*height) / 2 && x >= (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 200;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 200;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 200;
					}
				}
			}
			break;
		case UIImageOrientationLeft:
			*width = defaultHeight;
			*height = defaultWidth;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				for (int y = 0; y < (*height); y++) {
					if (y < (*height) / 2 && x < (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 255;
					}
					else if (y <= (*height) / 2 && x >= (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 255;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 0;
					}
					else if (y >= (*height) / 2 && x < (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 200;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 200;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 200;
					}
					else if (y >= (*height) / 2 && x >= (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 255;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 0;
					}
				}
			}
			break;
		case UIImageOrientationRight:
			*width = defaultHeight;
			*height = defaultWidth;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				for (int y = 0; y < (*height); y++) {
					if (y < (*height) / 2 && x < (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 255;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 0;
					}
					else if (y <= (*height) / 2 && x >= (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 200;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 200;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 200;
					}
					else if (y >= (*height) / 2 && x < (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 255;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 0;
					}
					else if (y >= (*height) / 2 && x >= (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 255;
					}
				}
			}
			break;		
		case UIImageOrientationUpMirrored:
			*width = defaultWidth;
			*height = defaultHeight;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				for (int y = 0; y < (*height); y++) {
					if (y < (*height) / 2 && x < (*width) / 2) {
						(*pixel)[y * (*width) * 3 + x * 3 + 0] = 0;
						(*pixel)[y * (*width) * 3 + x * 3 + 1] = 255;
						(*pixel)[y * (*width) * 3 + x * 3 + 2] = 0;
					}
					else if (y <= (*height) / 2 && x >= (*width) / 2) {
						(*pixel)[y * (*width) * 3 + x * 3 + 0] = 255;
						(*pixel)[y * (*width) * 3 + x * 3 + 1] = 0;
						(*pixel)[y * (*width) * 3 + x * 3 + 2] = 0;
					}
					else if (y >= (*height) / 2 && x < (*width) / 2) {
						(*pixel)[y * (*width) * 3 + x * 3 + 0] = 200;
						(*pixel)[y * (*width) * 3 + x * 3 + 1] = 200;
						(*pixel)[y * (*width) * 3 + x * 3 + 2] = 200;
					}
					else if (y >= (*height) / 2 && x >= (*width) / 2) {
						(*pixel)[y * (*width) * 3 + x * 3 + 0] = 0;
						(*pixel)[y * (*width) * 3 + x * 3 + 1] = 0;
						(*pixel)[y * (*width) * 3 + x * 3 + 2] = 255;
					}
				}
			}
			break;			
		case UIImageOrientationDownMirrored:
			*width = defaultWidth;
			*height = defaultHeight;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				for (int y = 0; y < (*height); y++) {
					if (y < (*height) / 2 && x < (*width) / 2) {
						(*pixel)[y * (*width) * 3 + x * 3 + 0] = 0;
						(*pixel)[y * (*width) * 3 + x * 3 + 1] = 0;
						(*pixel)[y * (*width) * 3 + x * 3 + 2] = 255;
					}
					else if (y <= (*height) / 2 && x >= (*width) / 2) {
						(*pixel)[y * (*width) * 3 + x * 3 + 0] = 200;
						(*pixel)[y * (*width) * 3 + x * 3 + 1] = 200;
						(*pixel)[y * (*width) * 3 + x * 3 + 2] = 200;
					}
					else if (y >= (*height) / 2 && x < (*width) / 2) {
						(*pixel)[y * (*width) * 3 + x * 3 + 0] = 255;
						(*pixel)[y * (*width) * 3 + x * 3 + 1] = 0;
						(*pixel)[y * (*width) * 3 + x * 3 + 2] = 0;
					}
					else if (y >= (*height) / 2 && x >= (*width) / 2) {
						(*pixel)[y * (*width) * 3 + x * 3 + 0] = 0;
						(*pixel)[y * (*width) * 3 + x * 3 + 1] = 255;
						(*pixel)[y * (*width) * 3 + x * 3 + 2] = 0;
					}
				}
			}
			break;
		case UIImageOrientationLeftMirrored:
			*width = defaultHeight;
			*height = defaultWidth;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				for (int y = 0; y < (*height); y++) {
					if (y < (*height) / 2 && x < (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 200;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 200;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 200;
					}
					else if (y <= (*height) / 2 && x >= (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 255;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 0;
					}
					else if (y >= (*height) / 2 && x < (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 255;
					}
					else if (y >= (*height) / 2 && x >= (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 255;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 0;
					}
				}
			}
			break;
		case UIImageOrientationRightMirrored:
			*width = defaultHeight;
			*height = defaultWidth;
			*bytesPerPixel = defaultBytesPerPixel;
			*pixel = (unsigned char*)malloc(sizeof(unsigned char) * (*width) * (*height) * (*bytesPerPixel));
			for (int x = 0; x < (*width); x++) {
				for (int y = 0; y < (*height); y++) {
					if (y < (*height) / 2 && x < (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 255;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 0;
					}
					else if (y <= (*height) / 2 && x >= (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 255;
					}
					else if (y >= (*height) / 2 && x < (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 0;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 255;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 0;
					}
					else if (y >= (*height) / 2 && x >= (*width) / 2) {
						int tmpx = *width - x - 1;
						int tmpy = *height - y - 1;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 0] = 200;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 1] = 200;
						(*pixel)[tmpy * (*width) * 3 + tmpx * 3 + 2] = 200;
					}
				}
			}
			break;
		default:
			break;
	}
}