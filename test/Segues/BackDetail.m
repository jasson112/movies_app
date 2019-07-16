//
//  BackDetail.m
//  test
//
//  Created by jasson on 7/14/19.
//  Copyright © 2019 gability. All rights reserved.
//

#import "BackDetail.h"

@implementation BackDetail
- (void) perform{
    //create a screeshot form the current view that this make an user the ilusion than the view is still here but not
    UIGraphicsBeginImageContext(self.sourceViewController.view.bounds.size);
    //adding the view of moview list in back this make a illusion of the movies view is in background like a modal
    [self.sourceViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *copy = [[UIImageView alloc] initWithImage:viewImage];
    [[UIApplication sharedApplication].keyWindow addSubview:copy];
    
    [self.sourceViewController.navigationController popViewControllerAnimated:NO];
    [UIView animateWithDuration:0.4
                     animations:^{
                         //transform the screenshoot
                         CGAffineTransform transform = copy.transform;
                         transform = CGAffineTransformScale(transform, 0.1, 0.1);
                         copy.transform = transform;
                     }
                     completion:^(BOOL finished){
                         //remove the screenshoot form the upper view
                         [copy removeFromSuperview];
                     }];
}
@end
