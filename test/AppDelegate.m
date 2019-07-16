//
//  AppDelegate.m
//  test
//
//  Created by jasson on 6/26/19.
//  Copyright © 2019 gability. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //override background color
    [self window].backgroundColor = [UIColor whiteColor];

    return YES;
}

- (void)searchMoviesData:(NSString *)query filter:(NSString *)f done:(void (^)(NSMutableArray *))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSData *movieData = [standardUserDefaults objectForKey:[NSString stringWithFormat:@"movies_%@", f]];
        NSError *error = nil;
        __block NSDictionary *jsonArray = [[NSDictionary alloc] init];
        jsonArray = [NSJSONSerialization JSONObjectWithData:movieData options:kNilOptions error:&error];
        NSMutableArray *searchResult = [[NSMutableArray alloc] init];
        if(error == nil){
            //checks if the query is in local and added it to an array
            NSDictionary *myDict = (NSDictionary *) jsonArray;
            if([query length] == 0){
                block([myDict objectForKey:@"results"]);
                return;
            }
            for (NSDictionary *item in [myDict objectForKey:@"results"]) {
                NSString *name = (NSString *)[item objectForKey:@"title"];
                NSRange range = [[name lowercaseString] rangeOfString:[query lowercaseString]];
                if ( range.location != NSNotFound ){
                    [searchResult addObject:item];
                }
            }
        }
        //check if more result are in intrenet
        NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
        NSString * strUrl = [NSString stringWithFormat:@"https://api.themoviedb.org/3/search/movie?api_key=ff17be5f33ecef90e365ed15bab2eacc&language=en-US&query=%@&page=1&include_adult=false&region=us", query];
        NSURL *url = [NSURL URLWithString:strUrl];
        
        NSURLSessionDataTask *moviesTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            //adding the remote data in the array and returnet it into callback
            jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSArray *results = (NSArray *) [jsonArray objectForKey:@"results"];
            [searchResult addObjectsFromArray:results];
            block(searchResult);
        }];
        [moviesTask resume];
    });
}

- (void)getMoviesData:(NSString *)filter done:(void (^)(NSDictionary *))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //fetch data from cache
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSData *movieData = [standardUserDefaults objectForKey:[NSString stringWithFormat:@"movies_%@", filter]];
        __block NSDictionary *jsonArray = [[NSDictionary alloc] init];
        if(movieData == nil){
            //if not daata then try getting from internet
            NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
            NSString * strUrl = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=ff17be5f33ecef90e365ed15bab2eacc&language=en-US&page=1&region=us", filter];
            NSURL *url = [NSURL URLWithString:strUrl];
            
            NSURLSessionDataTask *moviesTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                //wehn fetch creates a chache data and return the object data as dictionary
                [standardUserDefaults setObject:data forKey:[NSString stringWithFormat:@"movies_%@", filter]];
                [standardUserDefaults synchronize];
                jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                block(jsonArray);
            }];
            [moviesTask resume];
        }else{
            //if the data exist in cache is returned if not the block is re called until the data is getted
            NSError *error = nil;
            jsonArray = [NSJSONSerialization JSONObjectWithData:movieData options:kNilOptions error:&error];
            if(error != nil){
                [standardUserDefaults setObject:nil forKey:@"movies"];
                [standardUserDefaults synchronize];
                [self getMoviesData:filter done:^(NSDictionary *result){
                    block(result);
                }];
            }else{
                block(jsonArray);
            }
        }
    });
}

- (void)getVideoData:(NSString *)theId done:(void (^)(NSString *))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //cehck if the movie has a trailer and then return the url without cache storage
        __block NSDictionary *jsonArray = [[NSDictionary alloc] init];
        NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
        NSString * strUrl = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/videos?api_key=ff17be5f33ecef90e365ed15bab2eacc", theId];
        NSURL *url = [NSURL URLWithString:strUrl];
        
        NSURLSessionDataTask *moviesTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSError *hasError = nil;
            jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&hasError];
            if(hasError == nil){
                NSArray *results = (NSArray *)[jsonArray objectForKey:@"results"];
                if([results count] > 0){
                    NSDictionary *firstResult = (NSDictionary *)[results objectAtIndex:0];
                    NSString *videoKey = (NSString *)[firstResult objectForKey:@"key"];
                    block([NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@", videoKey]);
                }else{
                    block(@"");
                }
            }else{
                block(@"");
            }
            
        }];
        [moviesTask resume];
    });
}

- (void)getMovieImageData:(NSString *)path done:(void (^)(UIImage *))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //get iamge from url
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSData *imageData = [standardUserDefaults objectForKey:path];
        __block UIImage *downloadedImage = [[UIImage alloc] init];
        if(imageData == nil){
            //if the image is not in cache
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w780/%@", path]];
            NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                //create a cache and then return as callback the data in an UIimage
                NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
                [standardUserDefaults setObject:[NSData dataWithContentsOfURL:location] forKey:path];
                [standardUserDefaults synchronize];
                downloadedImage = [UIImage imageWithData: [NSData dataWithContentsOfURL:location]];
                block(downloadedImage);
            }];
            [downloadPhotoTask resume];
        }else{
            //if the data exist the UIimage returned in callback
            downloadedImage = [UIImage imageWithData: imageData];
            block(downloadedImage);
        }
    });
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
