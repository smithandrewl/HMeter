unit FormSettings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, Buttons, IniPropStorage, ExtCtrls, MaskEdit;

type

  { TFormSettings }

  TFormSettings = class(TForm)
    BtnCancel: TBitBtn;
    BtnOk: TBitBtn;
    ColorButton1: TColorButton;
    IniPropStorage1: TIniPropStorage;
    Label1: TLabel;
    Label2: TLabel;
    lblTransparency: TLabel;
    lblRefreshInterval: TLabel;
    MaskEdit1: TMaskEdit;
    pagTabs: TPageControl;
    tabAppearance: TTabSheet;
    tabOther: TTabSheet;
    trkTransparency: TTrackBar;
    trkRefreshInterval: TTrackBar;
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

