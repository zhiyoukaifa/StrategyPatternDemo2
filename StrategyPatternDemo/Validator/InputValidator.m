//
//  InputValidator.m
//  StrategyPatternDemo
//
//  Created by 张三 on 2019/1/5.
//  Copyright © 2019 e家机械. All rights reserved.
//

#import "InputValidator.h"

@implementation InputValidator

- (void)limitInputContentOnEditing:(UITextField*)textFiled
{
    //zs20190115 需要子类重写
}
//zs20190105 需要子类重写
- (BOOL)validateInput:(UITextField*)input error:(NSError **)error
{
    if (error) {
        *error = nil;
    }
    return NO;
}

#pragma mark - zs20190115 长度限制
- (void)validateLength:(UITextField*)textField
{
    if(textField.text.length > self.lengthLimit) {//self是调用者 是子类
        textField.text = [textField.text substringToIndex:self.lengthLimit];
    }
}

#pragma mark - zs20190115 删除空格
- (void)deleteWhiteSpace:(UITextField*)textField
{
    [textField setText:[textField.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
}
#pragma mark - zs20190115 验证表情
- (void)validateEmojiLimit:(UITextField*)textField
{
    NSMutableString *tmpStr = [NSMutableString stringWithString:textField.text];
    [tmpStr enumerateSubstringsInRange:NSMakeRange(0 , [tmpStr length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                
//                                NSLog(@"substring___%@",substring);
                                BOOL filter = [self filterInputText:substring];
                                if (!filter) {
                                    [tmpStr deleteCharactersInRange:substringRange];
                                    [textField setText:[tmpStr copy]];
                                }
                            }];
}

/**
 *  @breif 对输入验证 输入文字 字母 数字 标点符号  NO 表示不是文字 字母 数字 标点符号
 */
- (BOOL)filterInputText:(NSString*)string
{
    NSString *searchText = string;
    
    //过滤文字 字母 数字
    NSRegularExpression *textRegex = [NSRegularExpression regularExpressionWithPattern:@"^[A-Za-z0-9\\u4e00-\\u9fa5\\f\\n\\r\\s]+$"
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
    
    NSTextCheckingResult *textRegexResult = [textRegex firstMatchInString:searchText
                                                                  options:0
                                                                    range:NSMakeRange(0, [searchText length])];
    
    //过滤标点符号
    NSRegularExpression *punctuationRegex = [NSRegularExpression regularExpressionWithPattern:@"\\p{P}"
                                                                                      options:NSRegularExpressionCaseInsensitive
                                                                                        error:nil];
    NSTextCheckingResult *punctuationRegexResult = [punctuationRegex firstMatchInString:searchText
                                                                                options:0
                                                                                  range:NSMakeRange(0, [searchText length])];
    
    
    BOOL isOK = textRegexResult || punctuationRegexResult;
    
    return isOK;
}




@end
