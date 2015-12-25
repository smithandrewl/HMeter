unit HNetInfo;

{$mode objfpc}{$F+}

interface

uses
  Classes, SysUtils;

type
  THNetInfo = class(TObject)
  private
    FModemType: string;
    FUptime: string;
    FTurboPageState: string;
    FThrottled: string;
    FTimeUntilRefill: string;
    FDailyLimit: string;
    FRefillAmount: string;
    FMegabytesLeft: string;

    function GetModemType: string;
    procedure SetModemType(const ModemType: string);
    function GetUptime: string;
    procedure SetUptime(const Uptime: string);
    function GetTurboPageState: string;
    procedure SetTurboPageState(const TurboPageState: string);
    function GetThrottled: string;
    procedure SetThrottled(const Throttled: string);
    function GetTimeUntilRefill: string;
    procedure SetTimeUntilRefill(const TimeUntilRefill: string);
    function GetDailyLimit: string;
    procedure SetDailyLimit(const DailyLimit: string);
    function GetRefillAmount: string;
    procedure SetRefillAmount(const RefillAmount: string);
    function GetMegabytesLeft: string;
    procedure SetMegabytesLeft(const MegabytesLeft: string);

  public
    constructor Create;
    destructor Destroy; override;
  published
    property ModemType: string read GetModemType write SetModemType;
    property Uptime: string read GetUptime write SetUptime;
    property TurboPageState: string read GetTurboPageState write SetTurboPageState;
    property Throttled: string read GetThrottled write SetThrottled;
    property TimeUntilRefill: string read GetTimeUntilRefill write SetTimeUntilRefill;
    property DailyLimit: string read GetDailyLimit write SetDailyLimit;
    property RefillAmount: string read GetRefillAmount write SetRefillAmount;
    property MegabytesLeft: string read GetMegabytesLeft write SetMegabytesLeft;
  end;


function FetchHNetInfo: THNetInfo;

implementation

constructor THNetInfo.Create;
begin

end;

destructor THNetInfo.Destroy;
begin

end;

function THNetInfo.GetModemType: string;
begin
  Result := FModemType;
end;

procedure THNetInfo.SetModemType(const ModemType: string);
begin
  FModemType := ModemType;
end;

function THNetInfo.GetUptime: string;
begin
  Result := FUptime;
end;

procedure THNetInfo.SetUptime(const Uptime: string);
begin
  FUptime := Uptime;
end;

function THNetInfo.GetTurboPageState: string;
begin
  Result := FTurboPageState;
end;

procedure THNetInfo.SetTurboPageState(const TurboPageState: string);
begin
  FTurboPageState := TurboPageState;
end;

function THNetInfo.GetThrottled: string;
begin
  Result := FThrottled;
end;

procedure THNetInfo.SetThrottled(const Throttled: string);
begin
  FThrottled := Throttled;
end;

function THNetInfo.GetTimeUntilRefill: string;
begin
  Result := FTimeUntilRefill;
end;

procedure THNetInfo.SetTimeUntilRefill(const TimeUntilRefill: string);
begin
  FTimeUntilRefill := TimeUntilRefill;
end;

function THNetInfo.GetDailyLimit: string;
begin
  Result := FDailyLimit;
end;

procedure THNetInfo.SetDailyLimit(const DailyLimit: string);
begin
  FDailyLimit := DailyLimit;
end;

function THNetInfo.GetRefillAmount: string;
begin
  Result := FRefillAmount;
end;

procedure THNetInfo.SetRefillAmount(const RefillAmount: string);
begin
  FRefillAmount := RefillAmount;
end;

function THNetInfo.GetMegabytesLeft: string;
begin
  Result := FMegabytesLeft;
end;

procedure THNetInfo.SetMegabytesLeft(const MegabytesLeft: string);
begin
  FMegabytesLeft := MegabytesLeft;
end;

function FetchHNetInfo: THNetInfo;
var
  Info: THNetInfo;
begin

  Info.ModemType       := 'ModemType';
  Info.Uptime          := 'Uptime';
  Info.TurboPageState  := 'TurboPageState';
  Info.Throttled       := 'Throttled';
  Info.TimeUntilRefill := 'TimeUntilRefill';
  Info.DailyLimit      := 'DailyLimit';
  Info.RefillAmount    := 'RefillAmount';
  Info.MegabytesLeft   := 'MegabytesLeft';

  result := Info;
end;

end.
