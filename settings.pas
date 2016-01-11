unit Settings;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils, Graphics;

type
TSettings = class(TObject)
private
  FFormBackgroundColor:   TColor;
  FFormTransparency: Integer;
  FChartLineColor:   TColor;
  FRefreshInterval:  Integer;
  FServerIp:         String;

public

  constructor Create;
  destructor Destroy; override;
  property FormBackgroundColor: TColor  read FFormBackgroundColor write FFormBackgroundColor;
  property FormTransparency: Integer read FFormTransparency write FFormTransparency;
  property ChartLineColor: TColor read FChartLineColor write FChartLineColor;
  property RefreshInterval: Integer read FRefreshInterval write FRefreshInterval;
  property ServerIp: String read FServerIp write FServerIp;
end;

implementation

constructor TSettings.Create;
begin

end;

destructor TSettings.Destroy;
begin

end;

end.

