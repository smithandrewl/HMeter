unit FormSettings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, Buttons;

type

  { TFormSettings }

  TFormSettings = class(TForm)
    BtnCancel: TBitBtn;
    BtnOk: TBitBtn;
    lblTransparency: TLabel;
    lblRefreshInterval: TLabel;
    pagTabs: TPageControl;
    tabAppearance: TTabSheet;
    tabOther: TTabSheet;
    trkTransparency: TTrackBar;
    trkRefreshInterval: TTrackBar;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  SettingsForm: TFormSettings;

implementation

{$R *.lfm}

end.

