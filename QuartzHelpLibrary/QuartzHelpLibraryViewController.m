/*
 * Quartz Help Library
 * QuartzHelpLibraryViewController.m
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

#import "QuartzHelpLibraryViewController.h"

#import "QuartzHelpLibrary.h"

@implementation QuartzHelpLibraryViewController

@synthesize image;

- (void)viewDidLoad {
	[super viewDidLoad];
	[imageView setImage:self.image];
}

- (IBAction)openImagePicker:(id)sender {
	
	UIImagePickerController *controller = [[UIImagePickerController alloc] init];
	[controller setDelegate:self];
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		[controller setSourceType:UIImagePickerControllerSourceTypeCamera];
	}
	
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

- (void)setBinarizedImageWithInfo:(NSDictionary *)info {
	UIImage *cameraImage = [info objectForKey:UIImagePickerControllerOriginalImage];
	
	int copiedWidth = 0;
	int copiedHeight = 0;
	unsigned char *copiedPixel = NULL;
	
	CGCreateGrayPixelBufferWithImage([cameraImage CGImage], &copiedPixel, &copiedWidth, &copiedHeight);
	
	int threshold = 120;
	
	// binarize
	for (int y = 0; y < copiedHeight; y++) {
		for (int x = 0; x < copiedWidth; x++) {
			copiedPixel[y * copiedWidth+ x] = copiedPixel[y * copiedWidth+ x] > threshold ? 255 : 0;
		}
	}
	
	CGImageRef binarizedImageRef = CGImageRGBColorCreateWithGrayPixelBuffer(copiedPixel, copiedWidth, copiedHeight);
	free(copiedPixel);
	
	self.image = [UIImage imageWithCGImage:binarizedImageRef];
	
	[imageView setImage:self.image];
	
	CGImageRelease(binarizedImageRef);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[self setBinarizedImageWithInfo:info];
	[picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissModalViewControllerAnimated:YES];
}

- (void)dealloc {
    [image release];
    [super dealloc];
}

@end
