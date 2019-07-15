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
    //self.destinationViewController.view.center = CGPointMake( self.sourceViewController.view.center.x, 0-self.destinationViewController.view.center.y);
    UIGraphicsBeginImageContext(self.sourceViewController.view.bounds.size);
    [self.sourceViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *copy = [[UIImageView alloc] initWithImage:viewImage];
    [[UIApplication sharedApplication].keyWindow addSubview:copy];
    //[self.sourceViewController.view addSubview:self.destinationViewController.view];
    //copy.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    [self.sourceViewController.navigationController popViewControllerAnimated:NO];
    [UIView animateWithDuration:0.4
                     animations:^{
                         //copy.center = CGPointMake( copy.center.x, 0-copy.center.y);
                         CGAffineTransform transform = copy.transform;
                         transform = CGAffineTransformScale(transform, 0.1, 0.1);
                         copy.transform = transform;
                         
                     }
                     completion:^(BOOL finished){
                         [copy removeFromSuperview];
                         //[self.sourceViewController.navigationController popViewControllerAnimated:NO];
                         //[self.sourceViewController.navigationController presentViewController:[self destinationViewController]  animated:NO completion:nil];
                         //[[self sourceViewController] presentViewController:[self destinationViewController] animated:NO completion:nil];
                     }];
}
@end
