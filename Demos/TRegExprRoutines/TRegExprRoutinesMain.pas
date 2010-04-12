unit TRegExprRoutinesMain;

{
  ����-�ਬ�� �ᯮ�짮����� TRegExpr

  �ᯮ�짮����� ��������� ��楤��
  �� ᠬ� ���⮩ ᯮᮡ, �� � ᠬ� ����䥪⨢��

   -=- �������� RegExpr.pas � ᯨ᮪ 䠩��� ��襣� �஥�� (��� ����
    �������� ��� 䠩� � ��⠫�� 䠩��� ��襣� �஥��):
      Delphi Main Menu -> Project -> Add to project..
   -=- �������� 'RegExpr' � ������ 'uses' �����, ��� �� �㤥� 
    �ᯮ�짮���� ��楤��� TRegExpr:
      Delphi Main Menu -> File -> Use Unit..
   -=- ������ ����� ���� ��뢠�� ��楤���, ���ਬ�� ExecRegExpr 
    (����� ᯨ᮪ ��楤�� ������� � ࠧ���� '����䥩� TRegExpr'
    ���㬥��樨 �� TRegExpr).

}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfmTRegExprRoutines = class(TForm)
    grpSearchOrValidate: TGroupBox;
    lblPhone: TLabel;
    edPhone: TComboBox;
    lblValidatePhoneRes: TLabel;
    btnValidatePhone: TBitBtn;
    edTextWithPhone: TComboBox;
    lblTextWithPhone: TLabel;
    lblSearchPhoneRes: TLabel;
    btnSearchPhone: TBitBtn;
    grpReplace: TGroupBox;
    lblSearchIn: TLabel;
    memSearchIn: TMemo;
    lblReplaceWith: TLabel;
    btnReplace: TBitBtn;
    edReplaceWith: TEdit;
    lblSearchFor: TLabel;
    edSearchFor: TEdit;
    memReplaceRes: TMemo;
    procedure btnSearchPhoneClick(Sender: TObject);
    procedure btnValidatePhoneClick(Sender: TObject);
    procedure btnReplaceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTRegExprRoutines: TfmTRegExprRoutines;

implementation

uses RegExpr;

{$R *.DFM}

procedure TfmTRegExprRoutines.btnSearchPhoneClick(Sender: TObject);
 begin
  if ExecRegExpr ('\d{3}-(\d{2}-\d{2}|\d{4})', edTextWithPhone.Text) then begin
     // �� ॣ��୮� ��ࠦ���� ���� �஢����,
     // ������� �� ���४�� ����� ⥫�䮭� � ��ப� edTextWithPhone
     lblSearchPhoneRes.Font.Color := clBlue;
     lblSearchPhoneRes.Caption := 'Phone number found';
     lblSearchPhoneRes.Visible := True;
    end
   else begin // Error in test
     lblSearchPhoneRes.Font.Color := clRed;
     lblSearchPhoneRes.Caption := 'There is no phone number in the Phone field';
     lblSearchPhoneRes.Visible := True;
     edPhone.SetFocus;
    end;
 end;

procedure TfmTRegExprRoutines.btnValidatePhoneClick(Sender: TObject);
 begin
  if ExecRegExpr ('^\s*\d{3}-(\d{2}-\d{2}|\d{4})\s*$', edPhone.Text) then begin
     // �� ॣ��୮� ��ࠦ���� �஢����, ���� �� ��ப� � �����
     // ���४�� ⥫�䮭�� ����஬. ����� �������� �� 
     // �ᯮ�짮����� \s* � ��砫� � � ����. ����� �����࠭�����
     // �訡�� ���짮��⥫�� - ��砩�� ���� �஡����. �� �஡���
     // ��⮬ �� ����� ���짮��⥫� � �� ��稭��� ����������� �
     // �㦡� ��.�����প� - "��祣� �� ࠡ�⠥�".
     // ���㬭� �������� ��.�����প� �� ��� �������, ���⮬� ��
     // ���� �������� �஡���.
     lblValidatePhoneRes.Font.Color := clBlue;
     lblValidatePhoneRes.Caption := 'Phone number is Ok';
     lblValidatePhoneRes.Visible := True;
    end
   else begin // Error in test
     lblValidatePhoneRes.Font.Color := clRed;
     lblValidatePhoneRes.Caption := 'Error in the Phone field';
     lblValidatePhoneRes.Visible := True;
     edPhone.SetFocus;
    end;
 end;

procedure TfmTRegExprRoutines.btnReplaceClick(Sender: TObject);
 begin
  memReplaceRes.Text := ReplaceRegExpr (edSearchFor.Text, memSearchIn.Text, edReplaceWith.Text);
 end;

end.
