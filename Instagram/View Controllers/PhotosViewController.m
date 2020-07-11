//
//  PhotosViewController.m
//  Instagram
//
//  Created by Jasdeep Gill on 7/7/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import "SceneDelegate.h"
#import "MBProgressHUD.h"

// MARK: Models
#import "Post.h"

// MARK: Controllers
#import "PhotosViewController.h"
#import "HomeFeedViewController.h"


@interface PhotosViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imagePostView;
@property (strong, nonatomic) IBOutlet UITextField *captionField;

@end

@implementation PhotosViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)didTapImage:(id)sender {

    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    self.imagePostView.image = [self resizeImage:originalImage withSize:CGSizeMake(300, 300)];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)didTapPost:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Post postUserImage:self.imagePostView.image withCaption:[self.captionField text] withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(succeeded){
            NSLog(@"posting image success");
            self.imagePostView.image = [UIImage imageNamed: @"image_placeholder.png"];
            self.captionField.text = @"";
            [self.tabBarController setSelectedIndex:0];
        }
        else{
            NSLog(@"Error posting image: %@", error.localizedDescription);
        }
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
