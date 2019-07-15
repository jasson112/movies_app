//
//  ViewController.h
//  test
//
//  Created by jasson on 6/26/19.
//  Copyright © 2019 gability. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource, UISearchBarDelegate>
@property (strong, nonatomic) NSString *filterBy;
@end

