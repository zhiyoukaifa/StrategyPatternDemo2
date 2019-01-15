//
//  NumericInputValidator.m
//  StrategyPatternDemo
//
//  Created by 张三 on 2019/1/5.
//  Copyright © 2019 e家机械. All rights reserved.
//

#import "NumericInputValidator.h"

@implementation NumericInputValidator


- (void)limitInputContentOnEditing:(UITextField*)textField
{
    //zs20190115 遍历字符串 干掉不符合表情符号
    [self validateEmojiLimit:textField];
    //zs20190115 限制空格
    [self deleteWhiteSpace:textField];
    //zs20190115 可以统一使用父类的
    [self validateLength:textField];

    [self validateNumberLimit:textField];
}

//zs20190115 输入的时候的限制
- (BOOL)validateInput:(UITextField*)input error:(NSError **)error
{
  
    
//zs20190115 输入结束后验证 或者点击确定的时候 最后的验证
    NSError *regError = nil;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"^[0-9]*$"
                                  options:NSRegularExpressionAnchorsMatchLines
                                  error:&regError];
    NSUInteger numberOfMatches = [regex
                                  numberOfMatchesInString:[input text]
                                  options:NSMatchingAnchored
                                  range:NSMakeRange(0, [[input text] length])];




//zs20190105 如果没有匹配，就返回错误和NO
    if (numberOfMatches == 0) {

        if (error != nil) {

            NSString *description = NSLocalizedString(@"Input Validation Failed", @"");
            NSString *reason = NSLocalizedString(@"The input can contain only numberical values", @"");
            NSArray *objArray = [NSArray arrayWithObjects:description,reason, nil];
            NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey,NSLocalizedFailureReasonErrorKey, nil];

            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:objArray forKey:keyArray];

            *error = [NSError
                      errorWithDomain:InputValidationErrorDomain
                      code:1001
                      userInfo:userInfo];
        }
        return NO;
    }
    
    return YES;
}
- (void)validateNumberLimit:(UITextField*)textField
{
    NSMutableString *tmpStr = [NSMutableString stringWithString:textField.text];
    [tmpStr enumerateSubstringsInRange:NSMakeRange(0 , [tmpStr length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                
                                NSLog(@"substring___%@",substring);
                                BOOL filter = [self filterInputText:substring];
                                if (!filter) {
                                    [tmpStr deleteCharactersInRange:substringRange];
                                    [textField setText:[tmpStr copy]];
                                }
                            }];
}

- (BOOL)filterInputText:(NSString*)string
{
    NSString *searchText = string;
    
    //过滤文字 字母 数字
    NSRegularExpression *textRegex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]*$"
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
    
    NSTextCheckingResult *textRegexResult = [textRegex firstMatchInString:searchText
                                                                  options:0
                                                                    range:NSMakeRange(0, [searchText length])];
    
    return textRegexResult;
}




@end
