//
//  testImageOrientation.h
//  QuartzHelpLibrary
//
//  Created by sonson on 11/05/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define QH_ORIENTATION_TEST_WIDTH			48
#define QH_ORIENTATION_TEST_HEIGHT			32
#define QH_ORIENTATION_TEST_BYTES_PER_PIXEL	3

void makeImage(unsigned char **pixel, int *width, int *height, int *bytesPerPixel, UIImageOrientation orientation);
