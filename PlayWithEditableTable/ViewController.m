//
//  ViewController.m
//  PlayWithEditableTable
//
//  Created by Aleksandra Borovytskaya on 5/9/15.
//  Copyright (c) 2015 Aleksandra Borovytskaya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *data; //
@property(weak, nonatomic) IBOutlet UITextField *textField;
@property(weak, nonatomic) IBOutlet UIButton *addText;
@property(weak, nonatomic) IBOutlet UIButton *editTable;

@end

@implementation ViewController

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        //создаем и инициалируем массив
        self.data = [NSMutableArray array];

    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

// создаем и регистрируем класс, который работает с таблицей: возвращает значение из ячейки,
// соответвующей заданному идентификатору
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];

}

//создаем таблицу, где кол-во строк равно количеству элементов массива
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

//создаем метод, в котором таблица генирирует ячейки, соответвующие заданному идентификатору, по требованию, а не все сразу
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    cell.textLabel.text = self.data[(NSUInteger) indexPath.row];

    return cell;
}

//методв, котором мы добавляем возможность редактировать ячейки
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//метод, в котором редактирование (удаление записей) возможно,только, если в массиве есть хотябы 1 запись
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.data removeObjectAtIndex:(NSUInteger) indexPath.row];
        self.editTable.enabled = self.data.count > 0;
        if (self.data.count==0) {
            self.editTable.selected = NO;
            self.tableView.editing = NO;
        }

        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];

    }
}

//     метод, который позволяет обрабатывать нажатие по кнопке (Add)и добавлять строку в массив.
- (IBAction)onAddRowTapped:(id)sender {


    NSUInteger currentIndex = self.data.count;
    NSString *string = self.textField.text;
    [self.data addObject:string];

// таблица апдейтится, только если в массиве есть хотябы 1 элемент.
    self.editTable.enabled = self.data.count > 0;


//Таблица начитает апдейтиться
    [self.tableView beginUpdates];


    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentIndex inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

//   после апдейта таблицы строка ввода ввода текста очищается, кнопка Add стнаовится неактивной
    self.textField.text = nil;
    self.addText.enabled = NO;

//Таблица зкаканчивает апдейтиться
    [self.tableView endUpdates];

}
// Метод, который делает кнопку Add активной, если в строке ввода текста есть хотябы 1 символ
- (IBAction)textChanged:(id)sender {
    self.addText.enabled = self.textField.text.length > 0;

}

//   после апдейта таблицы строка ввода ввода текста очищается
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

//Метод, который инверсирует значение кнопки Edit.
- (IBAction)editText:(id)sender {
    self.editTable.selected = !self.editTable.selected;

    self.tableView.editing = !self.tableView.editing;

}


@end
