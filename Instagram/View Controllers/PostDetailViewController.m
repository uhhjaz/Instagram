//
//  PostDetailViewController.m
//  Instagram
//
//  Created by Jasdeep Gill on 7/8/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import <Parse/Parse.h>

// MARK: Models
#import "IGUser.h"

// MARK: Controllers
#import "PostDetailViewController.h"


@interface PostDetailViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profileImageView;


@end

@implementation PostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.captionLabel.text = self.postIg[@"caption"];
    
    IGUser *user = self.postIg[@"author"];
    self.usernameLabel.text = user.username;
    
    NSNumber *numLikes = self.postIg[@"likeCount"];
    self.likeCountLabel.text = [numLikes stringValue];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:self.postIg[@"postedDate"]];
    [dateFormat setDateFormat:@"MMMM dd YYYY"];
    NSString* dateInWords = [dateFormat stringFromDate:date];
    self.dateLabel.text = dateInWords;
    
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2;
    self.profileImageView.file = user.profileImageView;
    [self.profileImageView loadInBackground];
    
    self.postImageView.file = self.postIg[@"image"];
    [self.postImageView loadInBackground];
    
}

- (IBAction)didTapLike:(id)sender {
    
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
