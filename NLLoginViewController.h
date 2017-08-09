//
//  NLLoginViewController.h
//  LoginViewController
//
//  Created by Thrymr on 08/08/17.
//  Copyright © 2017 Thrymr. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "objectType.h"

@interface NLLoginViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


#pragma mark - Login
//+(UITextField *)login:(UITextField *)textField name:(objectType)objType;

+(BOOL)validationsOfLoginWithUserName:(UITextField* )userName password:(UITextField* )password viewController:(UIViewController* )VC;



@end
