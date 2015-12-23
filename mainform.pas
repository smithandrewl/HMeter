unit mainForm;

{$mode objfpc}{$H+}

(*
  References:
    Drag & Drop
    http://forum.lazarus.freepascal.org/index.php?topic=11083.0
*)
interface

uses
  Classes, SysUtils, FileUtil, TAChartImageList, TASources, TAGraph, TASeries,
  TAStyles, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Image1: TImage;
    Label1: TLabel;
    RandomChartSource1: TRandomChartSource;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { private declarations }
    IsMouseDown : boolean;
    CursorStartX, CursorStartY : integer;

  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  IsMouseDown := True;
  CursorStartX := x;
  CursorStartY := y;

end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if IsMouseDown then
  begin
    Left := Left - CursorStartX + X;
    Top := Top - CursorStartY + y;
  end;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
      IsMouseDown := False;
end;
end.

