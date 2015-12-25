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
  TAStyles, TALegendPanel, RTTICtrls, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Menus, IniPropStorage, HNetInfo;

type

  { TFormMain }

  TFormMain = class(TForm)
    Chart: TChart;
    ChartLineSeries1: TLineSeries;
    ChartLineSeries2: TLineSeries;
    ChartLegendPanel1: TChartLegendPanel;
    grpDownloadLimit: TGroupBox;
    lblModemTypeValue: TLabel;
    lblUptimeValue: TLabel;
    lblTurboPageStateValue: TLabel;
    lblThrottledValue: TLabel;
    lblTimeUntilRefillValue: TLabel;
    lblRefillAmountValue: TLabel;
    lblMegabytesLeftValue: TLabel;
    StatusImage: TImage;
    lblDailyLimitValue: TLabel;
    lblRefillAmount: TLabel;
    lblModemType: TLabel;
    lblUptime: TLabel;
    lblTurboPageState: TLabel;
    lblThrottled: TLabel;
    lblTimeUntilRefill: TLabel;
    lblMegabytesLeft: TLabel;
    AppHideMenuItem: TMenuItem;
    SysTrayExitMenuItem: TMenuItem;
    AppExitMenuItem: TMenuItem;
    SysTrayPopupMenu: TPopupMenu;
    AppPopupMenu: TPopupMenu;
    RandomChartSource1: TRandomChartSource;
    RandomChartSource2: TRandomChartSource;
    RefreshTimer: TTimer;
    SysTray: TTrayIcon;


    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure AppHideMenuItemClick(Sender: TObject);
    procedure RefreshTimerTimer(Sender: TObject);
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
    IsMouseDown := True;
    CursorStartX := x;
    CursorStartY := y;
  end;
end;

procedure TFormMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  if IsMouseDown then
  begin
    Left := Left - CursorStartX + X;
    Top := Top - CursorStartY + y;
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

procedure TFormMain.RefreshTimerTimer(Sender: TObject);
var
  Info: THNetInfo;
begin
     (*

       Call function to return  a THNetInfo from the web URL:
         connect to the web url
         initialize a component to handle INI

         feed the component the stream
         get the values needed and populate an instance of THNetInfo

       Update the user interface using the THNetInfo instance
     *)

  Info := FetchHNetInfo();
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
  Visible := not Visible;
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


