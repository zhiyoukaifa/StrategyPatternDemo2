//
//  ViewController.m
//  StrategyPatternDemo
//
//  Created by 张三 on 2019/1/5.
//  Copyright © 2019 e家机械. All rights reserved.
//

#import "ViewController.h"
#import "CustomTextField.h"
#import "NumericInputValidator.h"
#import "AlphaInputValidator.h"


@interface ViewController ()<ZSLCustomTextFieldDelegate>

@property (nonatomic, strong) CustomTextField *numericTextField;

@property (nonatomic, strong) CustomTextField *alphaTextField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.numericTextField];
    [self.view addSubview:self.alphaTextField];
    
    self.numericTextField.frame = CGRectMake(50, 100, 200, 44);
    self.alphaTextField.frame = CGRectMake(50, 200, 200, 44);
    self.numericTextField.backgroundColor = [UIColor yellowColor];
    self.alphaTextField.backgroundColor = [UIColor yellowColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)textFieldDidChanged:(CustomTextField*)textField
{
    if ([textField markedTextRange] == nil) {//联想限制 联想的不做验证
        [(CustomTextField*)textField limitInputContentOnEditing];
    }
}
- (void)textFieldDidEndEditing:(CustomTextField *)textField
{
    [textField validate];
}

- (CustomTextField *)numericTextField
{
    if (_numericTextField == nil) {
        
        _numericTextField = [[CustomTextField alloc] init];
        _numericTextField.customDelegate = self;
        _numericTextField.placeholder = @"只能输入数字";
        _numericTextField.inputValidator = [[NumericInputValidator alloc] init];
        _numericTextField.inputValidator.strErrorMessage = @"您好，只能输入数字";
        _numericTextField.inputValidator.lengthLimit = 10;
        [_numericTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _numericTextField;
}
- (CustomTextField *)alphaTextField
{
    if (_alphaTextField == nil) {
        
        _alphaTextField = [[CustomTextField alloc] init];
        _alphaTextField.customDelegate = self;
        _alphaTextField.placeholder = @"只能输入字母";
        _alphaTextField.inputValidator = [[AlphaInputValidator alloc] init];
        _alphaTextField.inputValidator.strErrorMessage = @"您好，只能输入字母";
        _alphaTextField.inputValidator.lengthLimit = 10;

    }
    return _alphaTextField;
}
@end



//zs20190115 输入的时候 进行长度限
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    //zs20190115 这个时候 还可能需要进行表情符号的限制
//
//
////    return textField.text.length + string.length <= ((CustomTextField*)textField).inputValidator.lengthLimit;
//}
