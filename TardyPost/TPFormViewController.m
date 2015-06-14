//
//  TPFormViewController.m
//  TardyPost
//
//  Created by Jayanth Prathipati on 6/12/15.
//  Copyright (c) 2015 TouchTap Studios. All rights reserved.
//

#import "TPFormViewController.h"
#import "UIColor+BFPaperColors.h"
#import <Canvas.h>


@interface TPFormViewController () <UIImagePickerControllerDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITextView *instaCaption;
@property (weak, nonatomic) IBOutlet UILabel *tweetCountLabel;
@property (weak, nonatomic) IBOutlet UIView *labelShakeView;


@end

@implementation TPFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navBar setBarTintColor:[UIColor paperColorRed]];
    [self.navBar setBackgroundColor:[UIColor paperColorRed]];
    [self.topView setBackgroundColor:[UIColor paperColorRed]];
    [self.tweetCountLabel setTextColor:[UIColor paperColorRed]];
    [self.tweetCountLabel setText:@"150 Characters Remaining"];
    [self.labelShakeView setOpaque:YES];
    self.instaCaption.delegate = self;
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (IBAction)chooseButtonClicked:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    
    
    [self presentViewController:picker animated:YES completion:nil];
}


-(void) imagePickerController:(UIImagePickerController *)UIPicker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    [UIPicker dismissViewControllerAnimated:YES completion:nil];
    
    NSURL* localUrl = (NSURL *)[info valueForKey:UIImagePickerControllerReferenceURL];
    
    NSLog(@"%@", localUrl);
    
    [self.chooseButton setHidden:YES];
    [self.pictureView setImage: (UIImage*) [info objectForKey:UIImagePickerControllerOriginalImage]];
    
}


-(void)textViewDidChange:(UITextView *)textView
{
    int len = textView.text.length;
    [self.tweetCountLabel setText:[NSString stringWithFormat:@"%i Characters Remaining",150-len]];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text length] == 0)
    {
        if([textView.text length] != 0)
        {
            return YES;
        }
    }
    else if([[textView text] length] > 149)
    {
        [self.labelShakeView startCanvasAnimation];
        return NO;
    }
    return YES;
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
