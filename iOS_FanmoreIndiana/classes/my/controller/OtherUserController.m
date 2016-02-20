//
//  OtherUserController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/25.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "OtherUserController.h"
#import "UserModel.h"
#import <UIButton+WebCache.h>
#import "AdressController.h"
#import "ChangeNickNameController.h"

@interface OtherUserController ()<UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UserModel *userInfo;

@end

@implementation OtherUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:UserInfo];
    self.userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    
    [self.logo sd_setBackgroundImageWithURL:[NSURL URLWithString:self.userInfo.userHead] forState:UIControlStateNormal];
    self.userID.text = self.userInfo.userId;
    self.nickName.text = self.userInfo.realName;
    self.phone.text = self.userInfo.mobile;
    
    [self.tableView removeSpaces];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    switch (indexPath.row) {
        case 0:
        {
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
            break;
        }
        case 2:
        {
            ChangeNickNameController *nick = [story instantiateViewControllerWithIdentifier:@"ChangeNickNameController"];
            [self.navigationController pushViewController:nick animated:YES];
            break;
        }
        case 4:
        {
            AdressController *address = [story instantiateViewControllerWithIdentifier:@"AdressController"];
            [self.navigationController pushViewController:address animated:YES];
            break;
        }
        default:
            break;
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
//    [self.logo setImage:photoImage forState:UIControlStateNormal];
    NSData *data = nil;
    if (UIImagePNGRepresentation(photoImage) == nil) {
        
        data = UIImageJPEGRepresentation(photoImage, 1);
        
    } else {
        
        data = UIImagePNGRepresentation(photoImage);
    }
    
    NSString * imagefile = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [picker dismissViewControllerAnimated:YES completion:^{
        
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"profileType"] = @"0";
        params[@"profileData"] = imagefile;
        [SVProgressHUD showWithStatus:@"头像上传中，请稍候"];
        
        
        [UserLoginTool loginRequestPostWithFile:@"updateProfile" parame:params success:^(id json) {
            [SVProgressHUD dismiss];
            
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
//                [self loginSuccessWith:json[@"resultData"]];
                UserModel *user = [UserModel mj_objectWithKeyValues:json[@"resultData"][@"user"]];
                NSLog(@"userModel: %@",user);
                [self.logo sd_setImageWithURL:[NSURL URLWithString:user.userHead] forState:UIControlStateNormal];
                NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *fileName = [path stringByAppendingPathComponent:UserInfo];
                [NSKeyedArchiver archiveRootObject:user toFile:fileName];
                //保存新的token
                [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:AppToken];
//                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"头像上传失败"];
            //            NSLog(@"%@",error.description);
        } withFileKey:@"profiledata"];
        
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

//- (void)loginSuccessWith:(NSDictionary *) dic {
//    
//    UserModel *user = [UserModel mj_objectWithKeyValues:dic[@"user"]];
//    NSLog(@"userModel: %@",user);
//    
//    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *fileName = [path stringByAppendingPathComponent:UserInfo];
//    [NSKeyedArchiver archiveRootObject:user toFile:fileName];
//    //保存新的token
//    [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:AppToken];
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}

@end
