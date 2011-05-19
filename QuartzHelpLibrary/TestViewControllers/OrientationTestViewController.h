//
//  OrientationTestViewController.h
//  QuartzHelpLibrary
//
//  Created by sonson on 11/05/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OrientationTestViewController : UIViewController {
    IBOutlet UIImageView *true_up;
    IBOutlet UIImageView *true_down;
    IBOutlet UIImageView *true_left;
    IBOutlet UIImageView *true_right;
    IBOutlet UIImageView *true_upMirrored;
    IBOutlet UIImageView *true_downMirrored;
    IBOutlet UIImageView *true_leftMirrored;
    IBOutlet UIImageView *true_rightMirrored;
	
    IBOutlet UIImageView *up;
    IBOutlet UIImageView *down;
    IBOutlet UIImageView *left;
    IBOutlet UIImageView *right;
    IBOutlet UIImageView *upMirrored;
    IBOutlet UIImageView *downMirrored;
    IBOutlet UIImageView *leftMirrored;
    IBOutlet UIImageView *rightMirrored;
}

@end
