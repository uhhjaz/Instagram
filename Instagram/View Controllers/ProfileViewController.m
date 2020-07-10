//
//  ProfileViewController.m
//  Instagram
//
//  Created by Jasdeep Gill on 7/6/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import "ProfileViewController.h"
#import "HomeFeedViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "PostDetailViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "PhotoCell.h"
#import "Post.h"
#import "PhotoGridCell.h"
#import "IGUser.h"

@interface ProfileViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet PFImageView *profileImageView;
@property (strong, nonatomic) NSArray *myFeedPosts;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postCountLabel;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation ProfileViewController


- (void)viewWillAppear:(BOOL)animated {
    [self.collectionView reloadData];
    [self getMyFeed];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2;
   
    [self getMyFeed];
    
    
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int totalwidth = self.collectionView.bounds.size.width;
    int numberOfCellsPerRow = 3;
    int oddEven = indexPath.row / numberOfCellsPerRow % 2;
    int dimensions = (CGFloat)(totalwidth / numberOfCellsPerRow);
    if (oddEven == 0) {
        return CGSizeMake(dimensions, dimensions);
    } else {
        return CGSizeMake(dimensions, dimensions / 2);
    }
}


-(void) getProfile {
    IGUser *theUser = [IGUser currentUser];
    self.usernameLabel.text = theUser.username;
    self.postCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.myFeedPosts.count];
    self.nameLabel.text = theUser.name;
}


- (void) getMyFeed{
    
    //PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query whereKey:@"author" equalTo:[IGUser currentUser]];
    //[query ]

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            NSLog(@"Successfully got posts");
            self.myFeedPosts = posts;
            
            NSLog(@"My posts are: %@",self.myFeedPosts);
            [self getProfile];
            [self.collectionView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhotoGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoGridCell" forIndexPath:indexPath];
    cell.postIg = self.myFeedPosts[indexPath.item];

    [cell setPostImage];
    return cell;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.myFeedPosts.count;
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
