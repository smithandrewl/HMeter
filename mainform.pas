unit mainForm;

{$mode objfpc}{$H+}

(*
  References:
    Drag & Drop
    http://forum.lazarus.freepascal.org/index.php?topic=11083.0

  Notes:
    URL: http://192.168.0.1/getdeviceinfo/info.bin

    [Data]
    UplinkTXPower
    TurboPageState
    UpTime

    [Blob]
    FapThrottleState
    FapTimeUntilRefill
    AnytimeAllowanceRemaining
    AnytimePlanAllowance
    RefillAmount

*)
interface

uses
  Classes, SysUtils, FileUtil, TAChartImageList, TASources, TAGraph, TASeries,
  TAStyles, TALegendPanel, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Menus;

type

  { TForm1 }

  TForm1 = class(TForm)
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Chart1LineSeries2: TLineSeries;
    ChartLegendPanel1: TChartLegendPanel;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    RandomChartSource1: TRandomChartSource;
    RandomChartSource2: TRandomChartSource;
    TrayIcon1: TTrayIcon;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label2Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
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
  if Button = mbLeft then
  begin
    IsMouseDown := True;
    CursorStartX := x;
    CursorStartY := y;
  end;
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

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.Label6Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  Visible:= false;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
    application.Terminate();
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  application.Terminate();
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
  Visible := not Visible;
  IsMouseDown := false;
end;

end.

