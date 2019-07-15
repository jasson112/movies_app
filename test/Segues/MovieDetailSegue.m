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
    //self.destinationViewController.view.center = CGPointMake( self.sourceViewController.view.center.x, 0-self.destinationViewController.view.center.y);
    [self.sourceViewController.view addSubview:self.destinationViewController.view];
    self.destinationViewController.view.transform = CGAffineTransformMakeScale(0.0, 0.0);
    
    [UIView animateWithDuration:0.4
                     animations:^{
                         self.destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         
                     }
                     completion:^(BOOL finished){
                         [self.sourceViewController.navigationController pushViewController:[self destinationViewController] animated:NO];
                         //[self.sourceViewController.navigationController presentViewController:[self destinationViewController]  animated:NO completion:nil];
                         //[[self sourceViewController] presentViewController:[self destinationViewController] animated:NO completion:nil];
                     }];
}
@end
