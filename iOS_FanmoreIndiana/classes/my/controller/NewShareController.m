 //
//  NewShareController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/2/27.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "NewShareController.h"
#import <UIBarButtonItem+BlocksKit.h>
#import <UIImageView+WebCache.h>

@interface NewShareController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *selectImage;

@property (nonatomic, strong) NSString *first;
@property (nonatomic, strong) NSString *second;
@property (nonatomic, strong) NSString *third;
@property (nonatomic, strong) NSString *fourth;

@property (nonatomic, strong) NSString *firstMini;
@property (nonatomic, strong) NSString *secondMini;
@property (nonatomic, strong) NSString *thirdMini;
@property (nonatomic, strong) NSString *fourthMini;

@end

@implementation NewShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新增晒单";
    
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
        if (self.shareTitle.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入晒单标题"];
        }else if (self.shareDetail.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入晒单描述"];
        }else if ([self picturesAreTheSame]) {
            [SVProgressHUD showErrorWithStatus:@"请设置4张晒单图片"];
        }else if (self.shareTitle.text.length <= 5) {
            [SVProgressHUD showErrorWithStatus:@"晒单主题，不少于6个字"];
        }else {
            [self.shareDetail resignFirstResponder];
            [self.shareTitle resignFirstResponder];
            [self addShareOrdor];
        }
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

#pragma mark text

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"完成"]) {
        [textView resignFirstResponder];
    }
    
    return YES;
}


- (void)addShareOrdor {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"issueId"] = self.WinningModel.issueId;
    dic[@"title"] = self.shareTitle.text;
    dic[@"content"] = self.shareDetail.text;
    dic[@"filenames"] = [self getArrayFromImages];
    dic[@"miniFilenames"] = [self getArrayFromMiniImages];
    
    [SVProgressHUD showWithStatus:nil];
    [UserLoginTool loginRequestPostWithFile:@"addShareOrder" parame:dic success:^(id json) {
        LWLog(@"%@", json);
        [SVProgressHUD dismiss];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            [self.navigationController popViewControllerAnimated:YES];
        }if ([json[@"systemResultCode"] intValue] == 500) {
            [SVProgressHUD showErrorWithStatus:@"服务器错误"];
        }
    } failure:^(NSError *error) {
        LWLog(@"%@", error);
        [SVProgressHUD dismiss];
    } withFileKey:nil];
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
    
    [picker dismissViewControllerAnimated:YES completion:^{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        dic[@"profileData"] = [self getStringFromImage:photoImage];
        
        
        [SVProgressHUD showWithStatus:@"图片上传中"];
        [UserLoginTool loginRequestPostWithFile:@"addShareOrderImg" parame:dic success:^(id json) {
            LWLog(@"%@", json);
            [SVProgressHUD dismiss];
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
                if (_selectImage.tag == 101) {
                    [self.firstImage sd_setImageWithURL:[NSURL URLWithString:json[@"resultData"][@"miniUrl"]] placeholderImage:nil options:SDWebImageRetryFailed];
                    self.first = json[@"resultData"][@"filename"];
                    self.firstMini = json[@"resultData"][@"miniFilename"];
                }
                if (_selectImage.tag == 102) {
                    [self.secondImage sd_setImageWithURL:[NSURL URLWithString:json[@"resultData"][@"miniUrl"]] placeholderImage:nil options:SDWebImageRetryFailed];
                    self.second = json[@"resultData"][@"filename"];
                    self.secondMini = json[@"resultData"][@"miniFilename"];
                }
                if (_selectImage.tag == 103) {
                    [self.thirdImage sd_setImageWithURL:[NSURL URLWithString:json[@"resultData"][@"miniUrl"]] placeholderImage:nil options:SDWebImageRetryFailed];
                    self.third = json[@"resultData"][@"filename"];
                    self.thirdMini = json[@"resultData"][@"miniFilename"];
                }
                if (_selectImage.tag == 104) {
                    [self.fourthImage sd_setImageWithURL:[NSURL URLWithString:json[@"resultData"][@"miniUrl"]] placeholderImage:nil options:SDWebImageRetryFailed];
                    self.fourth = json[@"resultData"][@"filename"];
                    self.fourthMini = json[@"resultData"][@"miniFilename"];
                }
            }else {
                [SVProgressHUD showErrorWithStatus:@"图片上传失败"];
            }
        } failure:^(NSError *error) {
            LWLog(@"%@", error);
            [SVProgressHUD dismiss];
        } withFileKey:@"profileData"];
    }];
    
    
    
    

    

    
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
        return YES;
    }
    if ([self.secondImage.image isEqual:temp]) {
        return YES;
    }
    if ([self.thirdImage.image isEqual:temp]) {
        return NO;
    }
    if ([self.fourthImage.image isEqual:temp]) {
        return YES;
    }
    return NO;
}

- (NSString *)getArrayFromImages {
    
    NSMutableString *temp = [NSMutableString string];
    
    [temp appendString:self.first];
    [temp appendFormat:@",%@" ,self.second];
    [temp appendFormat:@",%@" ,self.third];
    [temp appendFormat:@",%@" ,self.fourth];
    
    return temp;
}

- (NSString *)getArrayFromMiniImages {
    NSMutableString *temp = [NSMutableString string];
    
    [temp appendString:self.firstMini];
    [temp appendFormat:@",%@" ,self.secondMini];
    [temp appendFormat:@",%@" ,self.thirdMini];
    [temp appendFormat:@",%@" ,self.fourthMini];
    
    return temp;
}

- (NSString *)getStringFromImage:(UIImage *) image {
    NSData *data = nil;
    if (UIImagePNGRepresentation(image) == nil) {
        
        data = UIImageJPEGRepresentation(image, 1);
        
    } else {
        
        data = UIImagePNGRepresentation(image);
    }
    
    NSString * imagefile = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return imagefile;
}

@end
