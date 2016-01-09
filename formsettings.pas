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
    colorbutton1: TColorButton;
    gbForm: TGroupBox;
    gbChart: TGroupBox;
    IniPropStorage1: TIniPropStorage;
    Label1: TLabel;
    Label2: TLabel;
    lblFormBackground: TLabel;
    lblFormBackground1: TLabel;
    lblRefreshInterval: TLabel;
    lblTransparency: TLabel;
    MaskEdit1: TMaskEdit;
    pagTabs: TPageControl;
    tabAppearance: TTabSheet;
    tabOther: TTabSheet;
    trkRefreshInterval: TTrackBar;
    trkTransparency: TTrackBar;
    procedure cbFormBackgroundChangeBounds(Sender: TObject);
    procedure cbFormBackgroundColorChanged(Sender: TObject);
    procedure ColorButton1ColorChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure trkTransparencyChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }

  end;

var
  SettingsForm: TFormSettings;

implementation

{$R *.lfm}

{ TFormSettings }

procedure TFormSettings.FormCreate(Sender: TObject);
begin
  trkTransparency.Position := inipropstorage1.ReadInteger('FormMain_AlphaBlendValue', 255);
  colorbutton1.ButtonColor:= inipropstorage1.ReadInteger('lineseriescolor', 0);
  cbFormBackground.ButtonColor := inipropstorage1.ReadInteger('formBackgroundColor', 0);
end;

procedure TFormSettings.cbFormBackgroundChangeBounds(Sender: TObject);
begin

end;

procedure TFormSettings.cbFormBackgroundColorChanged(Sender: TObject);
begin
  inipropstorage1.WriteInteger('formBackgroundColor', cbFormBackground.ButtonColor);
end;

procedure TFormSettings.ColorButton1ColorChanged(Sender: TObject);
begin
  inipropstorage1.WriteInteger('lineseriescolor', colorbutton1.ButtonColor);
end;


procedure TFormSettings.trkTransparencyChange(Sender: TObject);
begin
  inipropstorage1.WriteInteger('FormMain_AlphaBlendValue', trkTransparency.Position);
end;

end.

