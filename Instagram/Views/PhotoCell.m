//
//  PhotoCell.m
//  Instagram
//
//  Created by Jasdeep Gill on 7/7/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import <Parse/Parse.h>

// MARK: Models
#import "PhotoCell.h"
#import "DateTools.h"


@implementation PhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profilePictureView addGestureRecognizer:profileTapGestureRecognizer];
    [self.profilePictureView setUserInteractionEnabled:YES];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    [self.delegate photoCell:self didTap:self.postIg.author];
}


- (void)setPostValues {
    
    IGUser *user = self.postIg[@"author"];
    self.captionLabel.text = self.postIg[@"caption"];
    self.usernameLabel.text = user.username;
    self.profilePictureView.layer.cornerRadius = self.profilePictureView.frame.size.height / 2;
    self.profilePictureView.file = user.profileImageView;
    [self.profilePictureView loadInBackground];
    self.imagePostView.file = self.postIg[@"image"];
    [self.imagePostView loadInBackground];
    
    // Convert Date to String
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:self.postIg[@"postedDate"]];
    self.timeLabel.text = [date shortTimeAgoSinceNow];
    
}

@end
