//
//  TextStatusViewController.m
//  Attributes
//
//  Created by 张储祺 on 2018/3/14.
//  Copyright © 2018年 张储祺. All rights reserved.
//

#import "TextStatusViewController.h"
#import "ViewController.h"
@interface TextStatusViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation TextStatusViewController
-(void)setTestToAnalyse:(NSAttributedString *)testToAnalyse{
    _testToAnalyse = testToAnalyse ;
    if(self.view.window)[self updateUI] ;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES] ;
    [self updateUI] ;
}
-(void)updateUI{
    NSMutableAttributedString * string =[[NSMutableAttributedString alloc] initWithString:@"the color is : "] ;
    for(NSAttributedString * a in [self recordColors]){
        [string appendAttributedString:a] ;
    }
    self.testLabel.text =(NSString *) string ;
}
-(NSMutableArray *)recordColors{
    NSMutableArray * colorArray = [[NSMutableArray alloc] init] ;
    [self.testToAnalyse enumerateAttribute:NSBackgroundColorAttributeName inRange:NSMakeRange(0, [self.testToAnalyse length]) options:NSAttributedStringEnumerationReverse usingBlock:^(id value, NSRange range, BOOL *stop){
        
        NSString * temp = [[NSString alloc] initWithFormat:@"%@",value] ;
        NSLog(@"%s",[temp UTF8String]) ;
        NSAttributedString * string = [[NSAttributedString alloc] initWithString:temp] ;
        [colorArray addObject:string] ;
    }];
    NSLog(@"%@",colorArray) ;
    return colorArray ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation


@end
