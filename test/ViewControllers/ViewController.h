//
//  ViewController.h
//  test
//
//  Created by jasson on 6/26/19.
//  Copyright © 2019 gability. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource, UISearchBarDelegate>
//this is used to mantain a global variable and later when the controller is defined programatically is setted and used for fetch APi
@property (strong, nonatomic) NSString *filterBy;
@end

