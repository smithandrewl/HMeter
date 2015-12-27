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
  TAStyles, TALegendPanel, RTTICtrls, LvlGraphCtrl, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Menus, IniPropStorage, LResources, HNetInfo;

type

  { TFormMain }

  TFormMain = class(TForm)
    Chart:                   TChart;
    ChartLineSeries1:        TLineSeries;
    ChartLineSeries2:        TLineSeries;
    ChartLegendPanel1:       TChartLegendPanel;
    grpDownloadLimit:        TGroupBox;
    IdleTimer1:              TIdleTimer;
    lblDailyLimitValue:      TLabel;
    lblMegabytesLeft:        TLabel;
    lblMegabytesLeftValue:   TLabel;
    lblModemTypeValue:       TLabel;
    lblRefillAmount:         TLabel;
    lblRefillAmountValue:    TLabel;
    lblThrottled:            TLabel;
    lblThrottledValue:       TLabel;
    lblTimeUntilRefill:      TLabel;
    lblTimeUntilRefillValue: TLabel;
    lblUptimeValue:          TLabel;
    lblTurboPageStateValue:  TLabel;
    lblModemType:            TLabel;
    lblUptime:               TLabel;
    lblTurboPageState:       TLabel;
    AppHideMenuItem:         TMenuItem;
    StatusImage:             TImage;
    SysTrayExitMenuItem:     TMenuItem;
    AppExitMenuItem:         TMenuItem;
    SysTrayPopupMenu:        TPopupMenu;
    AppPopupMenu:            TPopupMenu;
    RandomChartSource1:      TRandomChartSource;
    RandomChartSource2:      TRandomChartSource;
    RefreshTimer:            TTimer;
    SysTray:                 TTrayIcon;


    procedure FormMouseDown(
      Sender: TObject;
      Button: TMouseButton;
      Shift:  TShiftState;
      X:      integer;
      Y:      integer
    );

    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);

    procedure FormMouseUp(
      Sender: TObject;
      Button: TMouseButton;
      Shift:  TShiftState;
      X:      integer;
      Y:      integer
    );

    procedure AppHideMenuItemClick(Sender: TObject);
    procedure IdleTimer1Timer(Sender: TObject);
    procedure SysTrayExitMenuItemClick(Sender: TObject);
    procedure AppExitMenuItemClick(Sender: TObject);
    procedure SysTrayClick(Sender: TObject);
  private
    { private declarations }
    IsMouseDown: boolean;
    CursorStartX, CursorStartY: integer;
    procedure UpdateUI(Info: THNetInfo);
  public
    { public declarations }

  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

procedure TFormMain.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if Button = mbLeft then
  begin
    IsMouseDown  := True;
    CursorStartX := x;
    CursorStartY := y;
  end;
end;



procedure TFormMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  if IsMouseDown then
  begin
    Left := Left - CursorStartX + X;
    Top  := Top  - CursorStartY + y;
  end;
end;

procedure TFormMain.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin

  IsMouseDown := False;
end;

procedure TFormMain.AppHideMenuItemClick(Sender: TObject);
begin
  Visible := False;
end;

procedure TFormMain.IdleTimer1Timer(Sender: TObject);
  var
    Info: THNetInfo;
  begin
    IdleTimer1.enabled := false;
    Info               := FetchHNetInfo();

    UpdateUI(Info);
end;

procedure TFormMain.SysTrayExitMenuItemClick(Sender: TObject);
begin
  application.Terminate();
end;

procedure TFormMain.AppExitMenuItemClick(Sender: TObject);
begin
  application.Terminate();
end;

procedure TFormMain.SysTrayClick(Sender: TObject);
begin
  Visible     := not Visible;
  IsMouseDown := False;
end;

procedure TFormMain.UpdateUI(Info: THNetInfo);
begin
  lblModemTypeValue.Caption       := Info.ModemType;
  lblUptimeValue.Caption          := Info.Uptime;
  lblTurboPageStateValue.Caption  := Info.TurboPageState;
  lblThrottledValue.Caption       := Info.Throttled;
  lblTimeUntilRefillValue.Caption := Info.TimeUntilRefill;
  lblDailyLimitValue.Caption      := Info.DailyLimit;
  lblRefillAmountValue.Caption    := Info.RefillAmount;
  lblMegabytesLeftValue.Caption   := Info.MegabytesLeft;
end;

end.


