//
//  ViewController.m
//  Attributes
//
//  Created by 张储祺 on 2018/3/13.
//  Copyright © 2018年 张储祺. All rights reserved.
//

#import "ViewController.h"
#import "TextStatusViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *TextBody;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UIButton *OutlineButton;

@end

@implementation ViewController
- (IBAction)changeBodySelectionColorToMatchButtonBackgroundColor:(UIButton *)sender {
    [self.TextBody.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.TextBody.selectedRange] ;
}

- (IBAction)outlineBodySelection:(UIButton *)sender {
    [self.TextBody.textStorage addAttributes:@{NSStrokeWidthAttributeName:@-3,NSStrokeColorAttributeName:[UIColor blackColor]} range:self.TextBody.selectedRange] ;
}

- (IBAction)unoutlineBodySelection:(UIButton *)sender {
    [self.TextBody.textStorage addAttributes:@{NSStrokeWidthAttributeName:@0} range:self.TextBody.selectedRange] ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString * title = [[NSMutableAttributedString alloc] initWithString:self.OutlineButton.currentTitle] ;
    [title setAttributes:@{NSStrokeWidthAttributeName:@3,NSStrokeColorAttributeName:self.OutlineButton.tintColor} range:NSMakeRange(0, [title length])] ;
    [self.OutlineButton setAttributedTitle:title forState:UIControlStateNormal] ;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES ];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontsChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil] ;
    [self usePreferredFonts] ;
}

-(void)preferredFontsChanged:(NSNotification *)notification{
    [self usePreferredFonts] ;
}
-(void) usePreferredFonts{
    self.TextBody.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody] ;
    self.Title.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1] ;
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES] ;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil] ;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"Text Analyse"]){
        if([segue.destinationViewController isKindOfClass:[TextStatusViewController class]]){
            TextStatusViewController * tsvc = (TextStatusViewController *)segue.destinationViewController ;
            tsvc.testToAnalyse = self.TextBody.textStorage ;
        }
    }
}


@end
