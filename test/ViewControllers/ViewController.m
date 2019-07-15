//
//  ViewController.m
//  test
//
//  Created by jasson on 6/26/19.
//  Copyright © 2019 gability. All rights reserved.
//

#import "ViewController.h"
#import "../CollectionView/MovieCell.h"
#import "DetailViewController.h"
#import "../AppDelegate.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) NSDictionary *movie;
@property (strong, nonatomic) AppDelegate *appDelegate;

@end

@implementation ViewController
@synthesize filterBy;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(filterBy == nil){
        filterBy = @"top_rated";
    }
    [self.appDelegate getMoviesData:self.filterBy done:^(NSDictionary *result){
        self.movies = [result objectForKey:@"results"];
        dispatch_async(dispatch_get_main_queue(), ^{
            // code here
            [self.collectionView reloadData];
        });
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    //UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    self.movie = (NSDictionary *)[self.movies objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"goToMovieDetail" sender:self.parentViewController];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.destinationViewController isKindOfClass:[DetailViewController class]]){
        DetailViewController *destination = (DetailViewController *) segue.destinationViewController;
        destination.name = [self.movie objectForKey:@"title"];
        destination.imageUrl = [self.movie objectForKey:@"poster_path"];
        destination.description = [self.movie objectForKey:@"overview"];
        destination.myId = [self.movie objectForKey:@"id"];
    }
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *identifier = @"MovieCell";
    MovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *result  = (NSDictionary *)[self.movies objectAtIndex:indexPath.row];

    cell.title.text = [result objectForKey:@"title"];
    if(![[result objectForKey:@"poster_path"] isKindOfClass:[NSNull class]]){
        [self.appDelegate getMovieImageData:[result objectForKey:@"poster_path"] done:^(UIImage *result){
            dispatch_async(dispatch_get_main_queue(), ^{
                // code here
                cell.image.image = result;
            });
        }];
    }
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0){
        [searchBar performSelector:@selector(resignFirstResponder)
                        withObject:nil
                        afterDelay:0];
        [self.appDelegate searchMoviesData:[searchBar text] filter:self.filterBy done:^(NSMutableArray *result){
            self.movies = result;
            dispatch_async(dispatch_get_main_queue(), ^{
                // code here
                [self.collectionView reloadData];
            });
        }];
    }
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    if(![[searchBar text] isEqualToString:@""]){
        [self.appDelegate searchMoviesData:[searchBar text] filter:self.filterBy done:^(NSMutableArray *result){
            self.movies = result;
            dispatch_async(dispatch_get_main_queue(), ^{
                // code here
                [self.collectionView reloadData];
            });
        }];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    
}

- (void)setNeedsFocusUpdate {
    
}

- (void)updateFocusIfNeeded {
    
}

@end
