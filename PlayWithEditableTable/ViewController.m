//
//  ViewController.m
//  PlayWithEditableTable
//
//  Created by Aleksandra Borovytskaya on 5/9/15.
//  Copyright (c) 2015 Aleksandra Borovytskaya. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Utils.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *data; //
@property(weak, nonatomic) IBOutlet UITextField *textField;
@property(weak, nonatomic) IBOutlet UIButton *addText;
@property(weak, nonatomic) IBOutlet UIButton *editTableButton;

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

// регистрируем класс, который сообщает таблице значение ячейки, соответвующей заданному идентификатору

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];

}

//сообщаем таблице что кол-во ее строк равно количеству элементов массива
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

//создаем метод, в котором таблица генирирует ячейки, соответвующие заданному идентификатору,
// по требованию, а не все сразу
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];

    //конфигурируем эту ячейку
    cell.textLabel.text = self.data[(NSUInteger) indexPath.row];
    if (indexPath.row<=2)    {
        cell.backgroundColor = [UIColor yellowColor];}
    else
        cell.backgroundColor = [UIColor whiteColor];
    return cell;

}

//метод, в котором мы сообщаем таблице, какие ячейки можно редактировать
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

//    упрощено, так как результат вычисление или yes или no
    return indexPath.row > 2;

}

//метод, в котором мы реагируем на пользовательское действие - удаление
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        удаляем соот-й эл-т из массива
        [self.data removeObjectAtIndex:(NSUInteger) indexPath.row];

//        выключаем редактирование если удалили посл элемент
        self.editTableButton.enabled = self.data.count > 3;
        if (self.data.count==3) {
            self.editTableButton.selected = NO;
            self.tableView.editing = NO;
        }

        [tableView beginUpdates];
//        меняем табл - удаляем ячейку
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];

    }
}

//     метод, который позволяет обрабатывать нажатие по кнопке (Add)и добавлять строку в массив.
- (IBAction)onAddRowTapped:(id)sender {

//   запоминаем макс индекс
    NSUInteger currentIndex = self.data.count;
    NSString *string = self.textField.text;
//    добавляем строку в массив
    [self.data addObject:string];

// разрешаем редактирование, только если в массиве есть хотябы 1 элемент, кроме нередактируемых
    self.editTableButton.enabled = self.data.count > 3;


//Таблица начитает апдейтиться
    [self.tableView beginUpdates];

//создаем индекс пас на кот будем инсертить ячейку
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentIndex inSection:0];

//    меняем табл - сообщаем, что будет добавленя ячейка на таком-то индекс пасе
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

//   после апдейта таблицы строка ввода ввода текста очищается, кнопка Add стнаовится неактивной
    self.textField.text = nil;
    self.addText.enabled = NO;

//Таблица зкаканчивает апдейтиться
    [self.tableView endUpdates];

}
// Метод, который делает кнопку Add активной, если в строке ввода текста есть хотябы 1 символ
- (IBAction)textChanged:(id)sender {


        BOOL isEmailValid = [self.textField.text validateEmail];

        self.textField.textColor = isEmailValid ? [UIColor blackColor] : [UIColor redColor];


    self.addText.enabled = isEmailValid;


}

//   прячем клавиатуру при нажатии на кнопку Done
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

//Метод который меняем состояние интерфейса (редактирование - только чтение)
- (IBAction)editText:(id)sender {

    //Инвертируем состояние кнопки Edit.
    self.editTableButton.selected = !self.editTableButton.selected;

    //Инвертируем состояние таблицы.

    self.tableView.editing = !self.tableView.editing;

}


@end
