//
//  PhotoMapViewController.m
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
#import "PhotoCell.h"

// MARK: Controllers
#import "HomeFeedViewController.h"
#import "LoginViewController.h"
#import "PostDetailViewController.h"
#import "ProfileViewController.h"


@interface HomeFeedViewController () <UITableViewDelegate, UITableViewDataSource, PhotoCellDelegate> 

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *feedPosts;
@property (strong, nonatomic) UIRefreshControl *refreshControl;


@end

@implementation HomeFeedViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    [self getFeed];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self getFeed];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getFeed) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];

}


- (IBAction)didTapLogout:(id)sender {
    
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
    
    [IGUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        NSLog(@"User logged out suggessfully");
    }];
}

- (void) getFeed{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    [query includeKey:@"author"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            NSLog(@"Successfully got posts");
            self.feedPosts = posts;
            [self.tableView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (void)photoCell:(PhotoCell *) photoCell didTap: (IGUser *)user {
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
}


// shows how many rows we have
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedPosts.count;
}


// creates and configures a cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // creates cell from photo
    PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
    cell.postIg = self.feedPosts[indexPath.row];
    cell.delegate = self;
    [cell setPostValues];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *gramPost = self.feedPosts[indexPath.row];
    
        // sends post info to next controller
        PostDetailViewController *postDetailViewController = [segue destinationViewController];
        postDetailViewController.postIg = gramPost;
    }
    else if([segue.identifier isEqualToString:@"profileSegue"]) {
        IGUser *user = sender;
        ProfileViewController *profileViewController = [segue destinationViewController];
        profileViewController.theUser = user;
    }
    
}


@end
