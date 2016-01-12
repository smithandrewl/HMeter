unit FormSettings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LvlGraphCtrl, TATools, TAStyles, TAChartListbox,
  TAChartExtentLink, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Buttons, IniPropStorage, ExtCtrls, MaskEdit, ButtonPanel;

type

  { TFormSettings }

  TFormSettings = class(TForm)
    BtnCancel: TBitBtn;
    BtnOk: TBitBtn;
    cbFormBackground: TColorButton;
    cbLineColor: TColorButton;
    cbBackgroundColor: TColorButton;
    gbForm: TGroupBox;
    gbChart: TGroupBox;
    IniPropStorage1: TIniPropStorage;
    Label1: TLabel;
    Label2: TLabel;
    lblFormBackground: TLabel;
    lblLineColor: TLabel;
    lblChartBackground: TLabel;
    lblRefreshInterval: TLabel;
    lblTransparency: TLabel;
    MaskEdit1: TMaskEdit;
    pagTabs: TPageControl;
    tabAppearance: TTabSheet;
    tabOther: TTabSheet;
    trkRefreshInterval: TTrackBar;
    trkTransparency: TTrackBar;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure cbFormBackgroundColorChanged(Sender: TObject);
    procedure ColorButton1ColorChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure trkTransparencyChange(Sender: TObject);
  private
    { private declarations }
    prevFormBackground: TColor;
    prevTransparency:   Integer;
    prevLineColor:      TColor;
  public
    { public declarations }

  end;

var
  SettingsForm: TFormSettings;

implementation

{$R *.lfm}

{ TFormSettings }

procedure TFormSettings.FormCreate(Sender: TObject);
var
  transparency:        Integer;
  lineColor:           TColor;
  formBackgroundColor: TColor;
begin
  transparency        := inipropstorage1.ReadInteger('FormMain_AlphaBlendValue', 255);
  lineColor           := inipropstorage1.ReadInteger('lineseriescolor', 0);
  formBackgroundColor := inipropstorage1.ReadInteger('formBackgroundColor', 0);

  trkTransparency.Position     := transparency;
  cbLineColor.ButtonColor     := lineColor;
  cbFormBackground.ButtonColor := formBackgroundColor;

  prevTransparency   := transparency;
  prevLineColor      := lineColor;
  prevFormBackground := formBackgroundColor;
end;

procedure TFormSettings.BtnOkClick(Sender: TObject);
begin
     visible := false;
end;

procedure TFormSettings.BtnCancelClick(Sender: TObject);
begin
  inipropstorage1.WriteInteger('formBackgroundColor', prevFormBackground);
  inipropstorage1.WriteInteger('lineseriescolor', prevLineColor);
  inipropstorage1.WriteInteger('FormMain_AlphaBlendValue', prevTransparency);

  visible := false;

  cbFormBackground.ButtonColor := prevFormBackground;
  cbLineColor.ButtonColor     := prevLineColor;
  trkTransparency.Position     := prevTransparency;
end;

procedure TFormSettings.cbFormBackgroundColorChanged(Sender: TObject);
begin
  inipropstorage1.WriteInteger('formBackgroundColor', cbFormBackground.ButtonColor);
end;

procedure TFormSettings.ColorButton1ColorChanged(Sender: TObject);
begin
  inipropstorage1.WriteInteger('lineseriescolor', cbLineColor.ButtonColor);
end;


procedure TFormSettings.trkTransparencyChange(Sender: TObject);
begin
  inipropstorage1.WriteInteger('FormMain_AlphaBlendValue', trkTransparency.Position);
end;

end.

