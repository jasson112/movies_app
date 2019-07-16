//
//  MovieDetailSegue.m
//  test
//
//  Created by jasson on 7/13/19.
//  Copyright © 2019 gability. All rights reserved.
// 

#import "MovieDetailSegue.h"

@implementation MovieDetailSegue
- (void) perform{
    //Adding the views for the animation
    [self.sourceViewController.view addSubview:self.destinationViewController.view];
    self.destinationViewController.view.transform = CGAffineTransformMakeScale(0.0, 0.0);
    
    [UIView animateWithDuration:0.4
                     animations:^{
                         self.destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                     }
                     completion:^(BOOL finished){
                         //hwen the animation ends the view has deleted and the controller itself is showing
                         [self.sourceViewController.navigationController pushViewController:[self destinationViewController] animated:NO];
                     }];
}
@end
