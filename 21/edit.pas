unit edit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TfEdit }

  TfEdit = class(TForm)
    CBNote: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    eName: TEdit;
    eTelephone: TEdit;
    bCancel: TBitBtn;
    bSave: TBitBtn;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fEdit: TfEdit;

implementation

{$R *.lfm}


procedure TfEdit.FormShow(Sender: TObject);
begin
  eName.SetFocus;
end;


end.

