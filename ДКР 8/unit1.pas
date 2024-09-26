unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, MMSystem;

type

  { TForm1 }

  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    ButtonSetAlarm: TButton;
    ButtonStopAlarm: TButton;
    LabelAlarm: TLabel;
    EditHour: TEdit;
    EditMinute: TEdit;
    procedure ButtonSetAlarmClick(Sender: TObject);
    procedure ButtonStopAlarmClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  FAlarmHour: Integer;
  FAlarmMinute: Integer;

implementation

{$R *.lfm}

procedure TForm1.ButtonSetAlarmClick(Sender: TObject);
var
  Hour, Minute: Integer;
begin
  Hour := StrToIntDef(EditHour.Text, -1);
  Minute := StrToIntDef(EditMinute.Text, -1);

  if (Hour >= 0) and (Hour <= 23) and (Minute >= 0) and (Minute <= 59) then
  begin
    FAlarmHour := Hour;
    FAlarmMinute := Minute;
    LabelAlarm.Caption := Format('%02d:%02d', [FAlarmHour, FAlarmMinute]);
    Timer1.Enabled := True;
  end
  else
    ShowMessage('Неверный формат времени!');
end;

procedure TForm1.ButtonStopAlarmClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  LabelAlarm.caption:= 'Приостановлено';
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  CurrentHour, CurrentMinute, CurrentSecond, CurrentMSec: Word;
begin
  DecodeTime(Now, CurrentHour, CurrentMinute, CurrentSecond, CurrentMSec);

  if (CurrentHour = FAlarmHour) and (CurrentMinute = FAlarmMinute) then
  begin
    Timer1.Enabled := False;
     // Воспроизведение звукового сигнала
    PlaySound('alarm.wav', 0, SND_FILENAME or SND_ASYNC);
    ShowMessage('Будильник сработал!');

  end;
end;

end.


