unit mainForm;

{$mode objfpc}{$H+}

(*
  References:
    Drag & Drop
    http://forum.lazarus.freepascal.org/index.php?topic=11083.0

    URL: http://192.168.0.1/getdeviceinfo/info.bin
*)
interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, TALegendPanel, RTTICtrls,
  IDEWindowIntf, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Menus,
  LResources, XMLPropStorage, IniPropStorage, ComCtrls, Buttons, HNetInfo,
  FormSettings;

type

  { TFormMain }

  TFormMain = class(TForm)
    bvlDrag: TBevel;
    btnResetGraph: TButton;
    Chart:                         TChart;
    ChartLineSeries1:              TLineSeries;
    ChartLegendPanel1:             TChartLegendPanel;
    grpDownloadLimit:              TGroupBox;
    IniPropStorage1: TIniPropStorage;
    lblReceiveSignalStrength:      TLabel;
    lblReceiveSignalStrengthValue: TLabel;
    lblRefillAmountValue:          TLabel;
    lblDailyLimit:                 TLabel;
    lblMegabytesLeft:              TLabel;
    lblMegabytesLeftValue:         TLabel;
    lblModemTypeValue:             TLabel;
    lblRefillAmount:               TLabel;
    lblDailyLimitValue:            TLabel;
    lblThrottled:                  TLabel;
    lblThrottledValue:             TLabel;
    lblTimeUntilRefill:            TLabel;
    lblTimeUntilRefillValue:       TLabel;
    lblUptimeValue:                TLabel;
    lblTurboPageStateValue:        TLabel;
    lblModemType:                  TLabel;
    lblUptime:                     TLabel;
    lblTurboPageState:             TLabel;
    AppHideMenuItem:               TMenuItem;
    lblDrag: TStaticText;
    StatusImageUnknown: TImage;
    SysTraySettingsMenuItem: TMenuItem;
    StatusImageBarred:             TImage;
    StatusImageHigh:               TImage;
    StatusImageLow:                TImage;
    SysTrayExitMenuItem:           TMenuItem;
    AppExitMenuItem:               TMenuItem;
    SysTrayPopupMenu:              TPopupMenu;
    AppPopupMenu:                  TPopupMenu;
    RefreshTimer:                  TTimer;
    SysTray:                       TTrayIcon;
    Timer1:                        TTimer;


    procedure btnResetGraphClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
    procedure grpDownloadLimitClick(Sender: TObject);
    procedure SysTrayExitMenuItemClick(Sender: TObject);
    procedure AppExitMenuItemClick(Sender: TObject);
    procedure SysTrayClick(Sender: TObject);
    procedure SysTraySettingsMenuItemClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
    IsMouseDown: boolean;
    CursorStartX, CursorStartY: integer;
    procedure UpdateUI(Info: THNetInfo);
    procedure Refresh;
    procedure UpdateStatusImages(Barred: Boolean; Low: Boolean; High: Boolean);
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

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Refresh;
end;

procedure TFormMain.btnResetGraphClick(Sender: TObject);
begin
  ChartLineSeries1.Clear();
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

procedure TFormMain.grpDownloadLimitClick(Sender: TObject);
begin
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

procedure TFormMain.SysTraySettingsMenuItemClick(Sender: TObject);
begin
  SettingsForm.Visible:= true;
end;

procedure TFormMain.Timer1Timer(Sender: TObject);
begin
  Refresh;
end;

procedure TFormMain.Refresh;
  var
    Info: THNetInfo;
  begin
    Info := THNetInfo.Create;
    FetchHNetInfo(Info);

    self.BeginFormUpdate;
    UpdateUI(Info);
    self.EndFormUpdate;
    Info.Free;
end;

procedure TFormMain.UpdateUI(Info: THNetInfo);
var
  DataLeft: integer;
begin
  alphablendvalue := inipropstorage1.ReadInteger('FormMain_AlphaBlendValue', 255);
  chartLineSeries1.SeriesColor:= inipropstorage1.ReadInteger('lineseriescolor', 0);

  color := inipropstorage1.ReadInteger('formBackgroundColor', 0);

  lblModemTypeValue.Caption             := Info.ModemType;
  lblTurboPageStateValue.Caption        := Info.TurboPageState;
  lblThrottledValue.Caption             := Info.Throttled;
  lblUptimeValue.Caption                := Info.Uptime          + ' (d:h:m:s)';
  lblTimeUntilRefillValue.Caption       := Info.TimeUntilRefill + ' Minutes';
  lblDailyLimitValue.Caption            := Info.DailyLimit      + ' Megabytes';
  lblRefillAmountValue.Caption          := Info.RefillAmount    + ' Megabytes';
  lblMegabytesLeftValue.Caption         := Info.MegabytesLeft   + ' Megabytes';
  lblReceiveSignalStrengthValue.Caption := Info.ReceiveSignalStrength;

  if Info.ReceiveSignalStrength <> '???' then
  begin
    if ChartLineSeries1.Count > 100 then
    begin
        ChartLineSeries1.Delete(0);
    end;

    ChartLineSeries1.add( StrToFloat(Info.ReceiveSignalStrength));
  end;
  if Info.MegabytesLeft <> '???' then
  begin
    DataLeft := StrToInt(Info.MegabytesLeft);

    if DataLeft > 300 then
    begin
      UpdateStatusImages(false, false, true);
    end
    else if DataLeft > 200 then
    begin
      UpdateStatusImages(false, true, false);
    end
    else
    begin
      UpdateStatusImages(true, false, false);
    end;
  end
  else
  begin
    UpdateStatusImages(false, false, false);
  end
end;

procedure TFormMain.UpdateStatusImages(Barred: Boolean; Low: Boolean; High: Boolean);
begin

  StatusImageBarred.Visible  := Barred;
  StatusImageLow.Visible     := Low;
  StatusImageHigh.Visible    := High;
  StatusImageUnknown.Visible := false;

  if not Barred and not Low and not High then
  begin
    StatusImageUnknown.Visible := true;
  end;



end;

end.


