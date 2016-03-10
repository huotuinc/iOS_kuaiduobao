//
//  FanmoreUserController.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/25.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "FanmoreUserController.h"
#import "UserModel.h"
#import <UIButton+WebCache.h>
#import "AdressController.h"
#import "ChangeNickNameController.h"
#import "ChangePhoneController.m"
#import <ShareSDK/ShareSDK.h>

@interface FanmoreUserController ()<UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UserModel *userInfo;

@end

@implementation FanmoreUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:UserInfo];
    self.userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    
    [self.logo sd_setBackgroundImageWithURL:[NSURL URLWithString:self.userInfo.userHead] forState:UIControlStateNormal];
    
    [self.tableView removeSpaces];
    
    [self _initLabels];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)_initLabels {
    self.nickName.text = self.userInfo.realName;
    self.phone.text = self.userInfo.mobile;
    if (self.userInfo.wexinBanded) {
        self.weixin.text = @"已绑定";
        self.weixin.textColor = [UIColor blackColor];
    }else {
        self.weixin.text = @"未绑定";
        self.weixin.textColor = [UIColor redColor];
    }
    if (self.userInfo.qqBanded) {
        self.qq.text = @"已绑定";
        self.qq.textColor = [UIColor blackColor];
    }else {
        self.qq.text = @"未绑定";
        self.qq.textColor = [UIColor redColor];
    }
    
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
        case 1:
        {
            /**
             *  修改昵称
             */
            ChangeNickNameController *nick = [story instantiateViewControllerWithIdentifier:@"ChangeNickNameController"];
            [self.navigationController pushViewController:nick animated:YES];
            break;
        }
        case 2:
        {
            /**
             *  绑定手机
             */
            ChangePhoneController *phone = [story instantiateViewControllerWithIdentifier:@"ChangePhoneController"];
            [self.navigationController pushViewController:phone animated:YES];
            break;
        }
        case 3:
        {
            /**
             *  绑定微信或者揭榜
             */
            
            if (self.userInfo.wexinBanded) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"解除绑定" message:@"去定窑解除帐号与微信的关联么？/n解除后将无法使用微信登录此帐号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"解除绑定", nil];
                alert.tag = 1001;
                [alert show];
                
            }else {
                [self weichatEmpower];
            }
            
            break;
        }
        case 4:
        {
            /**
             *  绑定qq或者解绑
             */
            if (self.userInfo.qqBanded) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"解除绑定" message:@"去定窑解除帐号与微信的关联么？/n解除后将无法使用微信登录此帐号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"解除绑定", nil];
                alert.tag = 1002;
                [alert show];
            }else {
                [self qqEmpower];
            }
            break;
        }
        case 5:
        {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            AdressController *address = [story instantiateViewControllerWithIdentifier:@"AdressController"];
            address.tpye = 1;
            [self.navigationController pushViewController:address animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark alertView 

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001 && buttonIndex == 1) {
    //解除微信绑定
        [self unwarpWithType:3];
        
    }
    if (alertView.tag == 1001 && buttonIndex == 1) {
    //解除qq绑定
        
        [self unwarpWithType:2];
        
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

#pragma mark 第三方授权

/**
 *  绑定微信
 */
- (void)weichatEmpower {
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            LWLog(@"%@",user);
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            dic[@"unionId"] = user.uid;
            
            [UserLoginTool loginRequestGet:@"bingWeixin" parame:dic success:^(id json) {
                LWLog(@"%@",json);
                if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
                    [self loginSuccessWith:json[@"resultData"]];
                }
            } failure:^(NSError *error) {
                LWLog(@"%@",error);
            }];
            
        }else {
            LWLog(@"%@",error);
        }
    }];
}

/**
 *  绑定QQ
 */
- (void)qqEmpower {
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            LWLog(@"%@",user);
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            dic[@"unionId"] = user.uid;
            
            
            [UserLoginTool loginRequestGet:@"bindQq" parame:dic success:^(id json) {
                LWLog(@"%@",json);
                if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
                    [self loginSuccessWith:json[@"resultData"]];
                }
            } failure:^(NSError *error) {
                LWLog(@"%@",error);
            }];
        }else {
            LWLog(@"%@",error);
        }
    }];
}





#pragma mark 刷新用户数据
- (void)loginSuccessWith:(NSDictionary *) dic {
    
    UserModel *user = [UserModel mj_objectWithKeyValues:dic[@"user"]];
    NSLog(@"userModel: %@",user);
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:UserInfo];
    [NSKeyedArchiver archiveRootObject:user toFile:fileName];
    [[NSUserDefaults standardUserDefaults] setObject:Success forKey:LoginStatus];
    //保存新的token
    [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:AppToken];
    //购物车结算登陆时 需要提交数据
    AdressModel *address = [AdressModel mj_objectWithKeyValues:dic[@"user"][@"appMyAddressListModel"]];
    NSString *fileNameAdd = [path stringByAppendingPathComponent:DefaultAddress];
    [NSKeyedArchiver archiveRootObject:address toFile:fileNameAdd];
    
    self.userInfo = user;
    
    [self _initLabels];
}

#pragma mark 解除绑定

/**
 *  解除绑定
 *
 *  @param type 1.手机 2.qq 3.微信
 */
- (void)unwarpWithType:(NSInteger) type {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"type"] = @(type);
    
    [UserLoginTool loginRequestGet:@"unwrap" parame:dic success:^(id json) {
        LWLog(@"%@", json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            [self loginSuccessWith:json[@"resultData"]];
        }
    } failure:^(NSError *error) {
        
    }];
    
}






@end
