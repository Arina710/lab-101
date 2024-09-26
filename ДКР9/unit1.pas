unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type

  { TFmain }

  TFmain = class(TForm)
    CourseComboBox: TComboBox;
    FIOVvod: TEdit;
    Nextt: TButton;
    FormaObucheniya: TLabel;
    FormaObucheniyaOchn: TRadioButton;
    FormaObucheniyaZaochn: TRadioButton;
    Course: TLabel;
    Previouss: TButton;
    NomerGruppiVvod: TEdit;
    FakultetVvod: TEdit;
    Fakultet: TLabel;
    FIO: TLabel;
    NomerGruppi: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NexttClick(Sender: TObject);
    procedure PrevioussClick(Sender: TObject);
    procedure FIOClick(Sender: TObject);
    procedure NaimenovChange(Sender: TObject);
    procedure PlatClick(Sender: TObject);
    procedure CourseChange(Sender: TObject);
    procedure NomerGruppiClick(Sender: TObject);
  private
    procedure GetRow(i: integer); //Процедура GetRow используется для извлечения данных из строки Data.Strings[i],
    procedure EditData(i: integer);
  public

  end;

var
  Fmain: TFmain;
  Data: TStringList;
  cur_row: integer;
  SelectedCourse: string; // Переменная для хранения выбранного жанра

implementation

{$R *.lfm}

{ TFmain }

procedure TFmain.FormShow(Sender: TObject);
begin
  Data := TStringList.Create;
  cur_row := 0;
  if FileExists('data.txt') then
  begin
    Data.LoadFromFile('data.txt');
    GetRow(cur_row);
  end;
  // Загрузка сохраненного значения комбобокса при отображении формы
  CourseComboBox.Text := SelectedCourse;
end;

procedure TFmain.NexttClick(Sender: TObject);
begin
  EditData(cur_row);
  if cur_row < Data.Count - 1 then
  begin
    cur_row := cur_row + 1;
    GetRow(cur_row);
  end
  else
  begin
    Data.Add('');
    cur_row += 1;
    FIOVvod.Clear;
    NomerGruppiVvod.Clear;
    CourseComboBox.Text := '';
    FakultetVvod.Clear;
    FormaObucheniyaOchn.Checked := False;
    FormaObucheniyaZaochn.Checked := False;
  end;
end;

procedure TFmain.PrevioussClick(Sender: TObject);
begin
  EditData(cur_row);
  if cur_row > 0 then
  begin
    cur_row := cur_row - 1;
    GetRow(cur_row);
  end;
end;

procedure TFmain.FIOClick(Sender: TObject);
begin

end;

procedure TFmain.NaimenovChange(Sender: TObject);
begin

end;

procedure TFmain.PlatClick(Sender: TObject);
begin

end;

procedure TFmain.CourseChange(Sender: TObject);
begin
  SelectedCourse := CourseComboBox.Text;
end;

procedure TFmain.NomerGruppiClick(Sender: TObject);
begin

end;

procedure TFmain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  EditData(cur_row);
  Data.SaveToFile('data.txt');
end;

procedure TFmain.FormCreate(Sender: TObject);
begin
  // Инициализация переменных или других необходимых операций при создании формы
end;

procedure TFmain.GetRow(i: integer);
var
  str: string;
begin
  str := Data.Strings[i];

  FIOVvod.Text := Copy(str, 1, Pos(',', str) - 1);
  Delete(str, 1, Pos(',', str));

  NomerGruppiVvod.Text := Copy(str, 1, Pos(',', str) - 1);
  Delete(str, 1, Pos(',', str));

  if Copy(str, 1, Pos(',', str) - 1) = '1' then
    FormaObucheniyaOchn.Checked := True
  else
    FormaObucheniyaZaochn.Checked := True;
  Delete(str, 1, Pos(',', str));

  CourseComboBox.Text := Copy(str, 1, Pos(',', str) - 1);
  Delete(str, 1, Pos(',', str));

  FakultetVvod.Text := str;
end;

procedure TFmain.EditData(i: integer);
var
  str: string;
begin
  if FormaObucheniyaOchn.Checked then
    str := '1'
  else
    str := '2';

  Data.Strings[i] := FIOVvod.Text + ',' + NomerGruppiVvod.Text + ',' + str + ',' + CourseComboBox.Text + ',' + FakultetVvod.Text;
end;

end.
