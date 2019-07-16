//
//  DetailViewController.m
//  test
//
//  Created by jasson on 7/14/19.
//  Copyright © 2019 gability. All rights reserved.
//

#import "DetailViewController.h"
#import "../AppDelegate.h"

@interface DetailViewController ()
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSString *videoUrl;
@end

@implementation DetailViewController

@synthesize image;
@synthesize theTitle;
@synthesize description;
@synthesize detail;
@synthesize name;
@synthesize imageUrl;
@synthesize myId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    theTitle.text = name;
    detail.text = description;
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(![imageUrl isKindOfClass:[NSNull class]]){
        //fetch data of img from url
        [self.appDelegate getMovieImageData:imageUrl done:^(UIImage *result){
            dispatch_async(dispatch_get_main_queue(), ^{
                // code here
                self.image.image = result;
            });
        }];
    } 
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButton:)];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = item;
    //cehcks if the movie has a video and then shows the button
    [self.appDelegate getVideoData:self.myId done:^(NSString *result){
        dispatch_async(dispatch_get_main_queue(), ^{
            // code here
            if(![result isEqualToString:@""]){
                self.videoUrl = result;
                UIBarButtonItem *itemVideo = [[UIBarButtonItem alloc] initWithTitle:@"View trailer" style:UIBarButtonItemStylePlain target:self action:@selector(viewVideo:)];
                self.navigationItem.rightBarButtonItem = itemVideo;
            }
        });
    }];
}

- (void)backButton:(id)sender {
    //perform custom segue for back to list
    [self performSegueWithIdentifier:@"backToMovies" sender:self.parentViewController];
}

- (void)viewVideo:(id)sender {
    //send the user to youtube to view the trailer
    NSURL* url = [[NSURL alloc] initWithString: self.videoUrl];
    [[UIApplication sharedApplication] openURL: url options:@{} completionHandler:nil];
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
