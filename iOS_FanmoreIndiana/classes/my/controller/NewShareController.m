//
//  NewShareController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/27.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "NewShareController.h"
#import <UIBarButtonItem+BlocksKit.h>

@interface NewShareController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>

@property (nonatomic, strong) UIImageView *selectImage;

@end

@implementation NewShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstImage.userInteractionEnabled = YES;
    [self.firstImage bk_whenTapped:^{
        self.selectImage = self.firstImage;
        [self goToChooseImage];
    }];
    
    self.secondImage.userInteractionEnabled = YES;
    [self.secondImage bk_whenTapped:^{
        self.selectImage = self.secondImage;
        [self goToChooseImage];
    }];
    
    self.thirdImage.userInteractionEnabled = YES;
    [self.thirdImage bk_whenTapped:^{
        self.selectImage = self.thirdImage;
        [self goToChooseImage];
    }];
    
    self.fourthImage.userInteractionEnabled = YES;
    [self.fourthImage bk_whenTapped:^{
        self.selectImage = self.fourthImage;
        [self goToChooseImage];
    }];
  
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"发布" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self _initGoodsInfomation];
    
    [self.shareDetail sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 44;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        if (KScreenWidth == 375) {
            return 310;
        }else if (KScreenWidth == 320){
            return 296;
        }else if (KScreenWidth == 414){
            return 320;
        }
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        return 141;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 1) {
        [self.shareDetail becomeFirstResponder];
    }
}

- (void)_initGoodsInfomation {
    self.goodName.text = self.WinningModel.title;
    self.goodIssueNo.text = [NSString stringWithFormat:@"%@", self.WinningModel.issueId];
    self.goodJoinCount.text = [NSString stringWithFormat:@"%@", self.WinningModel.toAmount];
    self.luckyNo.text = [NSString stringWithFormat:@"%@", self.WinningModel.luckyNumber];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.WinningModel.awardingDate doubleValue]];
    self.goodTime.text = [NSString stringWithFormat:@"揭晓时间：%@",[formatter stringFromDate:date]];
}

#pragma mark 调用现实图片

- (void)goToChooseImage {
    if (IsIos8) {
        
        UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:@"选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        UIAlertAction * photo = [UIAlertAction actionWithTitle:@"从本地相册选择图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UIImagePickerController * pc = [[UIImagePickerController alloc] init];
            pc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            pc.delegate = self;
            pc.allowsEditing = YES;
            [self presentViewController:pc animated:YES completion:nil];
        }];
        UIAlertAction * ceme  = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UIImagePickerController * pc = [[UIImagePickerController alloc] init];
            pc.allowsEditing = YES;
            pc.sourceType=UIImagePickerControllerSourceTypeCamera;
            pc.delegate = self;
            [self presentViewController:pc animated:YES completion:nil];
        }];
        [alertVc addAction:photo];
        [alertVc addAction:ceme];
        [alertVc addAction:action];
        [self presentViewController:alertVc animated:YES completion:nil];
    }else{
        
        UIActionSheet * aa = [[UIActionSheet alloc] initWithTitle:@"选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机", nil];
        [aa showInView:self.view];
        
    }
}

#pragma mark 拍照
/**
 *  拍照
 *
 *  @param picker
 *  @param info
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    UIImage *photoImage = nil;
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            photoImage = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            photoImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
    }
    
    self.selectImage.image = photoImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
/**
 *  取消拍照
 *
 *  @param picker
 */
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/**
 *    相机掉出
 *
 *  @param actionSheet <#actionSheet description#>
 *  @param buttonIndex <#buttonIndex description#>
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        UIImagePickerController * pc = [[UIImagePickerController alloc] init];
        pc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        pc.delegate = self;
        pc.allowsEditing = YES;
        [self presentViewController:pc animated:YES completion:nil];
        
    }else if(buttonIndex == 1) {
        
        UIImagePickerController * pc = [[UIImagePickerController alloc] init];
        pc.allowsEditing = YES;
        pc.sourceType=UIImagePickerControllerSourceTypeCamera;
        pc.delegate = self;
        [self presentViewController:pc animated:YES completion:nil];
    }
}


- (BOOL)picturesAreTheSame {
    UIImage *temp = [UIImage imageNamed:@"trtr"];
    if ([self.firstImage.image isEqual:temp]) {
        return NO;
    }
    if ([self.secondImage.image isEqual:temp]) {
        return NO;
    }
    if ([self.thirdImage.image isEqual:temp]) {
        return NO;
    }
    if ([self.fourthImage.image isEqual:temp]) {
        return NO;
    }
    
    return YES;
    
}

@end
