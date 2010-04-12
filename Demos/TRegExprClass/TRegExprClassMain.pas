unit TRegExprClassMain;

{

  ����-������ ������������� TRegExpr

  ������������� ������ TRegExpr, �.�. ����� ����������
  ������ �������������.

}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfmTRegExprClassMain = class(TForm)
    btnExtractEmails: TBitBtn;
    memExtractEmails: TMemo;
    lbxEMailesExtracted: TListBox;
    lblSearchPhoneIn: TLabel;
    memSearchPhoneIn: TMemo;
    Bevel1: TBevel;
    lblSubstituteTemplate: TLabel;
    memSubstituteTemplate: TMemo;
    btnSubstitutePhone: TBitBtn;
    memSubstitutePhoneRes: TMemo;
    procedure btnExtractEmailsClick(Sender: TObject);
    procedure btnSubstitutePhoneClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTRegExprClassMain: TfmTRegExprClassMain;

implementation

uses RegExpr;
{$R *.DFM}

// ��� ����������� ������� �������� ��� e-mail ������ �� ������� ������
// � �������� �� � �������������� ������ � ������� CSV (comma separated values)
function ExtractEmails (const AInputString : string) : string;

// �������� ��������, ��� ���� ��� ������� ����� �������������� �����,
// �� ���� ���������� ������ �� �����������.
// ���������� ����� ������������ ������� (��� ������������� ���������)
// ��������� TRegExpr � ��� ����������������� ����������

 const
  EmailRE = '[_a-zA-Z\d\-\.]+@[_a-zA-Z\d\-]+(\.[_a-zA-Z\d\-]+)+';
 var
  r : TRegExpr;
 begin
  Result := '';

  r := TRegExpr.Create;
  // �������� ������� - �� ��������� �� ����, 10% ����� �� ���
  // ������� � ���, ��� ������ �������� ������������, �� ������ ���.

  try // ����������� ������������ ������� �������� ������
     r.Expression := EmailRE;
	// ����������� �������� ����� ����������� ���������.
	// ��� ������ �� ������������� (��������, ��� ������ ������ Exec)
	// ��� ����� ���������������. ���� � ��������� ���� ������, �� 
	// ����� ������� ����������
     if r.Exec (AInputString) then
      REPEAT
       Result := Result + r.Match [0] + ',';
      UNTIL not r.ExecNext;
    finally r.Free;
   end;
 end;

procedure TfmTRegExprClassMain.btnExtractEmailsClick(Sender: TObject);
 begin
  lbxEMailesExtracted.Items.CommaText := ExtractEmails (memExtractEmails.Text);
 end;

// � ���� ������� �� �������� ���������� ����� �� ������� ������,
// �������� ��� �� ������������ (��� ������, ��� ������, ���������� ����� ��������).
// ����� ��������� ��� ��� � ������.
function ParsePhone (const AInputString, ATemplate : string) : string;
 const
  IntPhoneRE = '(\+\d *)?(\(\d+\) *)?\d+(-\d*)*';
 var
  r : TRegExpr;
 begin
  r := TRegExpr.Create; 
  // �������� ������� - �� ��������� �� ����, 10% ����� �� ���
  // ������� � ���, ��� ������ �������� ������������, �� ������ ���.

  try // ����������� ������������ ������� �������� ������
     r.Expression := IntPhoneRE;
	// ����������� �������� ����� ����������� ���������.
	// ��� ������ �� ������������� (��������, ��� ������ ������ Exec)
	// ��� ����� ���������������. ���� � ��������� ���� ������, �� 
	// ����� ������� ����������
     if r.Exec (AInputString)
      then Result := r.Substitute (ATemplate)
      else Result := '';
    finally r.Free;
   end;
 end;

procedure TfmTRegExprClassMain.btnSubstitutePhoneClick(Sender: TObject);
 begin
  memSubstitutePhoneRes.Text := ParsePhone (memSearchPhoneIn.Text, memSubstituteTemplate.Text);
 end;

end.
