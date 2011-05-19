//
//  OrientationTestViewController.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/05/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OrientationTestViewController.h"

#import "QuartzHelpLibrary.h"

@implementation OrientationTestViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	BOOL hidden = self.navigationController.navigationBar.hidden;
	[self.navigationController setNavigationBarHidden:!hidden animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[self setTitle:NSStringFromClass([self class])];
	[self.navigationController.navigationBar setTranslucent:YES];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.navigationController.navigationBar setTranslucent:NO];	
}

- (void)makeImage:(unsigned char**)pixel width:(int*)width height:(int*)height bytesPerPixel:(int*)bytesPerPixel orientation:(UIImageOrientation)orientation {
	int defaultWidth = 48;
	int defaultHeight = 32;
	int defaultBytesPerPixel = 3;
	
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

- (void)showImage {
	int width = 48;
	int height = 32;
	int bytesPerPixel = 3;
	unsigned char *pixel = NULL;
	
	[self makeImage:&pixel width:&width height:&height bytesPerPixel:&bytesPerPixel orientation:UIImageOrientationUp];
	CGImageRef source = CGImageCreateWithPixelBuffer(pixel, width, height, bytesPerPixel, QH_PIXEL_COLOR);
	free(pixel);
	
	
	int rot[8];
	{
		int *p = rot;
		*p++ = UIImageOrientationUp;
		*p++ = UIImageOrientationUpMirrored;
		*p++ = UIImageOrientationDown;
		*p++ = UIImageOrientationDownMirrored;
		*p++ = UIImageOrientationLeft;
		*p++ = UIImageOrientationLeftMirrored;
		*p++ = UIImageOrientationRight;
		*p++ = UIImageOrientationRightMirrored;
	}
	
	UIImageView *trueImageViews[8];
	{
		UIImageView **p = trueImageViews;
		*p++ = true_up;
		*p++ = true_upMirrored;
		*p++ = true_down;
		*p++ = true_downMirrored;
		*p++ = true_left;
		*p++ = true_leftMirrored;
		*p++ = true_right;
		*p++ = true_rightMirrored;
	}
	
	UIImageView *testImageViews[8];
	{
		UIImageView **p = testImageViews;
		*p++ = up;
		*p++ = upMirrored;
		*p++ = down;
		*p++ = downMirrored;
		*p++ = left;
		*p++ = leftMirrored;
		*p++ = right;
		*p++ = rightMirrored;
	}
	
	for (int i = 0; i < 8; i++) {
		UIImage *image = [UIImage imageWithCGImage:source scale:1 orientation:rot[i]];
		[trueImageViews[i] setImage:image];
		[testImageViews[i] setImage:[image getRotatedImage]];
	}

	CGImageRelease(source);
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[self showImage];
}

@end
