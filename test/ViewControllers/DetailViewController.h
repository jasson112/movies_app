//
//  DetailViewController.h
//  test
//
//  Created by jasson on 7/14/19.
//  Copyright © 2019 gability. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UITextView *detail;
@property (strong, nonatomic) IBOutlet UILabel *theTitle;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *myId;
@end

NS_ASSUME_NONNULL_END
