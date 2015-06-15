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




@interface TPFormViewController () <UIImagePickerControllerDelegate, UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITextView *instaCaption;
@property (weak, nonatomic) IBOutlet UILabel *tweetCountLabel;
@property (weak, nonatomic) IBOutlet UIView *labelShakeView;
@property (nonatomic, strong) NSArray *tagsArray;
@property (weak, nonatomic) UIImagePickerController *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *dateText;
@property UIImage *imageSelected;
@property(nonatomic, assign) int viewCount;




@end


@implementation UITextField (DisableCopyPaste)

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(cut:) || action == @selector(copy:) ||
        action == @selector(select:))
        {
                return [super canPerformAction:action withSender:sender];
        }
        return NO;
}

@end


@implementation TPFormViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.viewCount = 0;
    [self.navBar setBarTintColor:[UIColor paperColorRed]];
    [self.navBar setBackgroundColor:[UIColor paperColorRed]];
    [self.topView setBackgroundColor:[UIColor paperColorRed]];
    [self.tweetCountLabel setTextColor:[UIColor paperColorRed]];
    [self.tweetCountLabel setText:@"0 Characters"];
    [self.labelShakeView setOpaque:YES];
    [self.dateText setText: [self getCurrentDateString]];
    [[self.dateText valueForKey:@"textInputTraits"] setValue:[UIColor clearColor] forKey:@"insertionPointColor"];
    [self.dateText setDelegate:self];
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setMinimumDate: [NSDate date]];
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [datePicker addTarget:self action:@selector(dateIsChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    
    self.dateText.inputView = datePicker;
    self.instaCaption.delegate = self;

}

- (void)viewDidAppear:(BOOL)animated {
    
    if (self.viewCount > 0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if ((self.imageSelected == nil || self.imageSelected == NULL) && self.viewCount == 0)
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
        self.viewCount++;
    }
    
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


//- (IBAction)chooseButtonClicked:(id)sender {
//    
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    picker.delegate = self;
//
//    [self presentViewController:picker animated:YES completion:nil];
//}




-(NSString *) getCurrentDateString {
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy/MM/dd h:mm a"];
    return [DateFormatter stringFromDate:[NSDate date]];
}

- (IBAction)dateTextClicked:(id)sender {
    [self.dateText setTextColor:[UIColor blueColor]];
    [NSThread sleepForTimeInterval:0.5f];
    [self.dateText setTextColor:[UIColor lightGrayColor]];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


#pragma mark - ImagePickerDelegate Methods

-(void) imagePickerController:(UIImagePickerController *)UIPicker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    [UIPicker dismissViewControllerAnimated:YES completion:nil];
    
    NSURL* localUrl = (NSURL *)[info valueForKey:UIImagePickerControllerReferenceURL];
    
    NSLog(@"%@", localUrl);
    self.imageSelected = (UIImage*) [info objectForKey:UIImagePickerControllerOriginalImage];
    
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.view.superview removeFromSuperview];
}



#pragma mark - TextViewDelegate Methods


-(void)textViewDidChange:(UITextView *)textView
{
    NSUInteger textLength = textView.text.length;
    int len = (int)textLength;
    [self.tweetCountLabel setText:[NSString stringWithFormat:@"%i Characters", len]];
}


#pragma mark - DatePicker Methods

- (void)dateIsChanged:(UIDatePicker *)datePicker{
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy/MM/dd h:mm a"];
    NSString *dateString = [DateFormatter stringFromDate:[datePicker date]];
    [self.dateText setText:dateString];
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
