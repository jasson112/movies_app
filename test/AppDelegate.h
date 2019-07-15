//
//  AppDelegate.h
//  test
//
//  Created by jasson on 6/26/19.
//  Copyright © 2019 gability. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void)getMoviesData:(NSString *)filter done:(void (^)(NSDictionary *))block;
- (void)getMovieImageData:(NSString *)path done:(void (^)(UIImage *))block;
- (void)getVideoData:(NSString *)theId done:(void (^)(NSString *))block;
- (void)searchMoviesData:(NSString *)query filter:(NSString *)f done:(void (^)(NSMutableArray *))block;
@end

