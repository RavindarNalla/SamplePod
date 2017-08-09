//
//  NLLoginViewController.m
//  LoginViewController
//
//  Created by Thrymr on 08/08/17.
//  Copyright © 2017 Thrymr. All rights reserved.
//

#import "NLLoginViewController.h"


@interface NLLoginViewController ()
{
    UITextField *txtFieldTemp;
}
@end

@implementation NLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.userNameTextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.passwordTextField.secureTextEntry = YES;
}

//+(UITextField *)login:(UITextField *)textField name:(objectType)objType {
//    
//    switch (objType) {
//        case userNameTF:
//            textField.keyboardType = UIKeyboardTypeEmailAddress;
//            
//            break;
//        case passwordTF:
//            textField.secureTextEntry = YES;
//            break;
//            
//        default:
//            break;
//    }
//    
//    return textField;
//    
//}

+(BOOL)validationsOfLoginWithUserName:(UITextField* )userName password:(UITextField* )password viewController:(UIViewController* )VC {
    
    [userName resignFirstResponder];
    [password resignFirstResponder];
    
    @try{
        
        if (userName.text.length>0) {
            if (password.text.length>0) {
                BOOL value=[self NSStringIsValidEmail:[NSString stringWithFormat:@"%@",userName.text]];
                
                if (value)
                {
                    
                        NSLog(@"++++>> Checked Validations. ");
                    
                        return YES;
                }
                else{
                    [self alertWithMessage:@"Please enter a valid email id" viewController:VC];
                }
            }
            else{
                [self alertWithMessage:@"Please enter your Password" viewController:VC];
            }
        }
        else{
            [self alertWithMessage:@"Please enter your email" viewController:VC];
        }
    }
    @catch (NSException *exception)
    {
    }
    @finally
    {
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  – mark Textfield Delegate Methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField

{
    textField.layer.borderWidth=2;
    textField.layer.borderColor=[[UIColor redColor] CGColor];
    textField.layer.cornerRadius=6;

    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(btnDoneToolBarClicked:)],
                           nil];
    [numberToolbar sizeToFit];
    textField.inputAccessoryView = numberToolbar;
    txtFieldTemp = textField;
    return YES;

}

-(void)btnDoneToolBarClicked:(id)sender{
    
    if(txtFieldTemp)
        [txtFieldTemp resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField  {
    
     [self animateTextField:textField up:YES withOffset:textField.frame.origin.y / 2];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField

{
    textField.layer.borderColor = [[UIColor  clearColor] CGColor];
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self animateTextField:textField up:NO withOffset:textField.frame.origin.y / 2];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField  {
    
    return NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    if(textField == _userNameTextField)
    {
        [_passwordTextField becomeFirstResponder];
    }
    
    return YES;
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up withOffset:(CGFloat)offset
{
    const int movementDistance = -offset;
    const float movementDuration = 0.4f;
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

/**
 Email Validation.
 
 @param checkString => CheckString from emailTF text.
 @return => Validation of CheckString.
 */
+(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


/**
 Alert

 @param strMessage => Validation message
 @param VC => The controller in which you want to show Alert
 */
+(void)alertWithMessage:(NSString *)strMessage viewController:(UIViewController *)VC
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController* alertView = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                           message:strMessage
                                                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                   }];
        [alertView addAction:ok];
        
        [VC  presentViewController:alertView animated:YES completion:nil];
    });
    
}

@end
