unit HNetInfo;

{$mode objfpc}{$F+}

interface

uses
  Classes, SysUtils, IniFiles, httpsend;

type
  THNetInfo = class(TObject)
  private
    FModemType:             string;
    FUptime:                string;
    FTurboPageState:        string;
    FThrottled:             string;
    FTimeUntilRefill:       string;
    FDailyLimit:            string;
    FRefillAmount:          string;
    FMegabytesLeft:         string;
    FReceiveSignalStrength: string;

    function GetModemType:             string;
    function GetUptime:                string;
    function GetTurboPageState:        string;
    function GetThrottled:             string;
    function GetTimeUntilRefill:       string;
    function GetDailyLimit:            string;
    function GetRefillAmount:          string;
    function GetMegabytesLeft:         string;
    function GetReceiveSignalStrength: string;

    procedure SetUptime(const Uptime: string);
    procedure SetTurboPageState(const TurboPageState: string);
    procedure SetThrottled(const Throttled: string);
    procedure SetTimeUntilRefill(const TimeUntilRefill: string);
    procedure SetDailyLimit(const DailyLimit: string);
    procedure SetMegabytesLeft(const MegabytesLeft: string);
    procedure SetRefillAmount(const RefillAmount: string);
    procedure SetModemType(const ModemType: string);
    procedure SetReceiveSignalStrength(const ReceiveSignalStrength: string);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property ModemType:             string read GetModemType             write SetModemType;
    property Uptime:                string read GetUptime                write SetUptime;
    property TurboPageState:        string read GetTurboPageState        write SetTurboPageState;
    property Throttled:             string read GetThrottled             write SetThrottled;
    property TimeUntilRefill:       string read GetTimeUntilRefill       write SetTimeUntilRefill;
    property DailyLimit:            string read GetDailyLimit            write SetDailyLimit;
    property RefillAmount:          string read GetRefillAmount          write SetRefillAmount;
    property MegabytesLeft:         string read GetMegabytesLeft         write SetMegabytesLeft;
    property ReceiveSignalStrength: string read GetReceiveSignalStrength write SetReceiveSignalStrength;
  end;


function FetchHNetInfo: THNetInfo;

implementation

function THNetInfo.GetReceiveSignalStrength: string;
begin
  result := FReceiveSignalStrength;
end;

procedure THNetInfo.SetReceiveSignalStrength(const ReceiveSignalStrength: string);
begin
  FReceiveSignalStrength := ReceiveSignalStrength;
end;

constructor THNetInfo.Create;
begin
  inherited Create;
end;

destructor THNetInfo.Destroy;
begin
  inherited Destroy;
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
  Info:       THNetInfo;
  Data:       TIniFile;
  DataStream: TMemoryStream;
begin

  DataStream := TMemoryStream.Create;

  try
    HttpGetBinary('http://192.168.0.1/getdeviceinfo/info.bin', DataStream);
    DataStream.Position := 0;

    Data := TIniFile.Create(DataStream);

    Info := THNetInfo.Create;

    Info.ModemType             := Data.ReadString('Data', 'STModel',                   '???');
    Info.Uptime                := Data.ReadString('Data', 'Uptime',                    '???');
    Info.TurboPageState        := Data.ReadString('Data', 'TurboPageState',            '???');
    Info.Throttled             := Data.ReadString('Blob', 'FapThrottleState',          '???');
    Info.TimeUntilRefill       := Data.ReadString('Blob', 'FapTimeUntilRefill',        '???');
    Info.DailyLimit            := Data.ReadString('Blob', 'AnytimePlanAllowance',      '???');
    Info.RefillAmount          := Data.ReadString('Blob', 'RefillAmount',              '???');
    Info.MegabytesLeft         := Data.ReadString('Blob', 'AnytimeAllowanceRemaining', '???');
    Info.ReceiveSignalStrength := Data.ReadString('Data', 'CurrentSQF',                '???');

    if Info.TurboPageState = '0' then
       Info.TurboPageState := 'On'
    else
        Info.TurboPageState := 'Off';

    if Info.Throttled = '0' then
       Info.Throttled := 'Yes'
    else
        Info.Throttled := 'No';

  finally
    DataStream.Free;
    Data.Free;
  end;

  result := Info;
end;

end.
