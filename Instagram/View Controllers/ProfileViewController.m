//
//  ProfileViewController.m
//  Instagram
//
//  Created by Jasdeep Gill on 7/6/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import "SceneDelegate.h"
#import <Parse/Parse.h>

// MARK: Models
#import "Post.h"
#import "IGUser.h"

// MARK: Views
#import "PhotoGridCell.h"

// MARK: Controllers
#import "HomeFeedViewController.h"
#import "LoginViewController.h"
#import "PostDetailViewController.h"
#import "ProfileViewController.h"


@interface ProfileViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet PFImageView *profileImageView;
@property (strong, nonatomic) NSArray *userPosts;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postCountLabel;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation ProfileViewController


- (void)viewWillAppear:(BOOL)animated {
    [self.collectionView reloadData];
    [self getFeed];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2;
   
    [self getFeed];
    
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int totalwidth = self.collectionView.bounds.size.width;
    int numberOfCellsPerRow = 3;
    int dimensions = (CGFloat)(totalwidth / numberOfCellsPerRow);
    return CGSizeMake(dimensions, dimensions);
}


- (void) getProfile {
    self.usernameLabel.text = self.theUser.username;
    self.postCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.userPosts.count];
    self.nameLabel.text = self.theUser.name;
    self.profileImageView.file = self.theUser.profileImageView;
    [self.profileImageView loadInBackground];
}


- (void) getFeed{
    
    //check if fetching your own profile
    if (self.theUser == nil) {
        self.theUser = [IGUser currentUser];
    }
    
    //PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query whereKey:@"author" equalTo:self.theUser];
    //[query ]

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            NSLog(@"Successfully got posts");
            self.userPosts = posts;
            
            NSLog(@"My posts are: %@",self.userPosts);
            [self getProfile];
            [self.collectionView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhotoGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoGridCell" forIndexPath:indexPath];
    cell.postIg = self.userPosts[indexPath.item];

    [cell setPostImage];
    return cell;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userPosts.count;
}


- (IBAction)didTapProfileImage:(id)sender {
    if (self.theUser == [IGUser currentUser]) {
        UIImagePickerController *imagePickerVC = [UIImagePickerController new];
        imagePickerVC.delegate = self;
        imagePickerVC.allowsEditing = YES;
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }
    else {
        NSLog(@"not current user's profile page");
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *resizedImage = [self resizeImage:originalImage withSize:CGSizeMake(200, 100)];
    
    // Dismiss UIImagePickerController to go back original view controller
    [self dismissViewControllerAnimated:YES completion:^{
        [IGUser updateUserProfileImage:resizedImage withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if(succeeded){
                NSLog(@"updating profile image successful");
                [self getProfile];
            } else{
                NSLog(@"Error posting image: %@", error.localizedDescription);
            }
        }];
    }];
}


- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
UICollectionViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
    Post *post = self.userPosts[indexPath.row];

    PostDetailViewController *postDetailViewController = [segue destinationViewController];
    postDetailViewController.postIg = post;
}


@end
