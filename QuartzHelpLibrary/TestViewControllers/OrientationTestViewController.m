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
	
	UIImage *image = nil;
	
	image = [UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationUp];
	[true_up setImage:image];
	[up setImage:[UIImage imageWithCGImage:image.CGImage]];
	
	
	image = [UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationDown];
	[true_down setImage:image];
	
	CGImageRef rotatedCGImage = NULL;
	
	rotatedCGImage = [image createCGImageRotated];
	[down setImage:[UIImage imageWithCGImage:rotatedCGImage]];
	CGImageRelease(rotatedCGImage);
	
	image = [UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationLeft];
	[true_left setImage:image];
	
	rotatedCGImage = [image createCGImageRotated];
	[left setImage:[UIImage imageWithCGImage:rotatedCGImage]];
	CGImageRelease(rotatedCGImage);
	
	image = [UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationRight];
	[true_right setImage:image];
	
	rotatedCGImage = [image createCGImageRotated];
	[right setImage:[UIImage imageWithCGImage:rotatedCGImage]];
	CGImageRelease(rotatedCGImage);
	
	
	image = [UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationUpMirrored];
	[true_upMirrored setImage:image];
	
	rotatedCGImage = [image createCGImageRotated];
	[upMirrored setImage:[UIImage imageWithCGImage:rotatedCGImage]];
	CGImageRelease(rotatedCGImage);
	
	
	image = [UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationDownMirrored];
	[true_downMirrored setImage:image];
	
	rotatedCGImage = [image createCGImageRotated];
	[downMirrored setImage:[UIImage imageWithCGImage:rotatedCGImage]];
	CGImageRelease(rotatedCGImage);

	image = [UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationLeftMirrored];
	[true_leftMirrored setImage:image];
	
	rotatedCGImage = [image createCGImageRotated];
	[leftMirrored setImage:[UIImage imageWithCGImage:rotatedCGImage]];
	CGImageRelease(rotatedCGImage);
	
	image = [UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationRightMirrored];
	[true_rightMirrored setImage:image];
	
	rotatedCGImage = [image createCGImageRotated];
	[rightMirrored setImage:[UIImage imageWithCGImage:rotatedCGImage]];
	CGImageRelease(rotatedCGImage);
	
//	[true_leftMirrored setImage:[UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationLeftMirrored]];
//	[true_rightMirrored setImage:[UIImage imageWithCGImage:source scale:1 orientation:UIImageOrientationRightMirrored]];
/*	
	[self makeImage:&pixel width:&width height:&height bytesPerPixel:&bytesPerPixel orientation:UIImageOrientationUp];
	CGImageRef upSource = CGImageCreateWithPixelBuffer(pixel, width, height, bytesPerPixel, QH_PIXEL_COLOR);
	free(pixel);
	[up setImage:[UIImage imageWithCGImage:upSource]];
	CGImageRelease(upSource);
	
	[self makeImage:&pixel width:&width height:&height bytesPerPixel:&bytesPerPixel orientation:UIImageOrientationDown];
	CGImageRef downSource = CGImageCreateWithPixelBuffer(pixel, width, height, bytesPerPixel, QH_PIXEL_COLOR);
	free(pixel);
	[down setImage:[UIImage imageWithCGImage:downSource]];
	CGImageRelease(downSource);
	
	
	[self makeImage:&pixel width:&width height:&height bytesPerPixel:&bytesPerPixel orientation:UIImageOrientationLeft];
	CGImageRef leftSource = CGImageCreateWithPixelBuffer(pixel, width, height, bytesPerPixel, QH_PIXEL_COLOR);
	free(pixel);
	[left setImage:[UIImage imageWithCGImage:leftSource]];
	CGImageRelease(leftSource);
	
	[self makeImage:&pixel width:&width height:&height bytesPerPixel:&bytesPerPixel orientation:UIImageOrientationRight];
	CGImageRef rightSource = CGImageCreateWithPixelBuffer(pixel, width, height, bytesPerPixel, QH_PIXEL_COLOR);
	free(pixel);
	[right setImage:[UIImage imageWithCGImage:rightSource]];
	CGImageRelease(rightSource);
	
	[self makeImage:&pixel width:&width height:&height bytesPerPixel:&bytesPerPixel orientation:UIImageOrientationUpMirrored];
	CGImageRef upMirroredSource = CGImageCreateWithPixelBuffer(pixel, width, height, bytesPerPixel, QH_PIXEL_COLOR);
	free(pixel);
	[upMirrored setImage:[UIImage imageWithCGImage:upMirroredSource]];
	CGImageRelease(upMirroredSource);
	
	[self makeImage:&pixel width:&width height:&height bytesPerPixel:&bytesPerPixel orientation:UIImageOrientationDownMirrored];
	CGImageRef downMirroredSource = CGImageCreateWithPixelBuffer(pixel, width, height, bytesPerPixel, QH_PIXEL_COLOR);
	free(pixel);
	[downMirrored setImage:[UIImage imageWithCGImage:downMirroredSource]];
	CGImageRelease(downMirroredSource);
	
	[self makeImage:&pixel width:&width height:&height bytesPerPixel:&bytesPerPixel orientation:UIImageOrientationLeftMirrored];
	CGImageRef leftMirroredSource = CGImageCreateWithPixelBuffer(pixel, width, height, bytesPerPixel, QH_PIXEL_COLOR);
	free(pixel);
	[leftMirrored setImage:[UIImage imageWithCGImage:leftMirroredSource]];
	CGImageRelease(leftMirroredSource);
	
	[self makeImage:&pixel width:&width height:&height bytesPerPixel:&bytesPerPixel orientation:UIImageOrientationRightMirrored];
	CGImageRef rightMirroredSource = CGImageCreateWithPixelBuffer(pixel, width, height, bytesPerPixel, QH_PIXEL_COLOR);
	free(pixel);
	[rightMirrored setImage:[UIImage imageWithCGImage:rightMirroredSource]];
	CGImageRelease(rightMirroredSource);
*/	
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
