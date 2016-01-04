unit FormSettings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, Buttons, IniPropStorage;

type

  { TFormSettings }

  TFormSettings = class(TForm)
    BtnCancel: TBitBtn;
    BtnOk: TBitBtn;
    IniPropStorage1: TIniPropStorage;
    lblTransparency: TLabel;
    lblRefreshInterval: TLabel;
    pagTabs: TPageControl;
    tabAppearance: TTabSheet;
    tabOther: TTabSheet;
    trkTransparency: TTrackBar;
    trkRefreshInterval: TTrackBar;
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
end;

procedure TFormSettings.trkTransparencyChange(Sender: TObject);
begin
  inipropstorage1.WriteInteger('FormMain_AlphaBlendValue', trkTransparency.Position);
end;

end.

