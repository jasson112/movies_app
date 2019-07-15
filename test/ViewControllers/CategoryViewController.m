//
//  CategoryViewController.m
//  test
//
//  Created by jasson on 7/14/19.
//  Copyright © 2019 gability. All rights reserved.
//

#import "CategoryViewController.h"
#import "ViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSMutableArray* newArray = [NSMutableArray arrayWithArray:self.viewControllers];
    ViewController *popular = [storyboard instantiateViewControllerWithIdentifier:@"movieViewController"];
    popular.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Popular" image:nil tag:0];
    popular.filterBy = @"popular";
    [newArray addObject:popular];
    ViewController *upcoming = [storyboard instantiateViewControllerWithIdentifier:@"movieViewController"];
    upcoming.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Upcoming" image:nil tag:0];
    upcoming.filterBy = @"upcoming";
    [newArray addObject:upcoming];
    //[newArray removeObjectAtIndex:0];
    [self setViewControllers:newArray animated:NO];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
