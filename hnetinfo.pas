unit HNetInfo;

{$mode objfpc}{$F+}

interface

uses
  Classes, SysUtils, IniFiles, httpsend;

const
  InfoUrl = 'http://192.168.0.1/getdeviceinfo/info.bin';
  MsgNoModemFound = 'No Modem Found.';
  MsgUnknownValue = '???';
  MsgOn = 'On';
  MsgOff = 'Off';
  MsgYes = 'Yes';
  MsgNo = 'No';

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
  public
    constructor Create;
    destructor Destroy; override;
  published
    property ModemType:             string read FModemType             write FModemType;
    property Uptime:                string read FUptime                write FUptime;
    property TurboPageState:        string read FTurboPageState        write FTurboPageState;
    property Throttled:             string read FThrottled             write FThrottled;
    property TimeUntilRefill:       string read FTimeUntilRefill       write FTimeUntilRefill;
    property DailyLimit:            string read FDailyLimit            write FDailyLimit;
    property RefillAmount:          string read FRefillAmount          write FRefillAmount;
    property MegabytesLeft:         string read FMegabytesLeft         write FMegabytesLeft;
    property ReceiveSignalStrength: string read FReceiveSignalStrength write FReceiveSignalStrength;
  end;


procedure FetchHNetInfo(Info: THNetInfo);

implementation

constructor THNetInfo.Create;
begin
  inherited Create;
end;

destructor THNetInfo.Destroy;
begin
  inherited Destroy;
end;

procedure FetchHNetInfo(Info: THNetInfo);
var
  Data:       TIniFile;
  DataStream: TMemoryStream;
begin
  DataStream := TMemoryStream.Create;

  try
    HttpGetBinary(InfoUrl, DataStream);
    DataStream.Position := 0;

    Data := TIniFile.Create(DataStream);

    with Info do
    begin
      ModemType             := Data.ReadString('Data', 'STModel',                   MsgNoModemFound);
      Uptime                := Data.ReadString('Data', 'Uptime',                    MsgUnknownValue);
      TurboPageState        := Data.ReadString('Data', 'TurboPageState',            MsgUnknownValue);
      Throttled             := Data.ReadString('Blob', 'FapThrottleState',          MsgUnknownValue);
      TimeUntilRefill       := Data.ReadString('Blob', 'FapTimeUntilRefill',        MsgUnknownValue);
      DailyLimit            := Data.ReadString('Blob', 'AnytimePlanAllowance',      MsgUnknownValue);
      RefillAmount          := Data.ReadString('Blob', 'RefillAmount',              MsgUnknownValue);
      MegabytesLeft         := Data.ReadString('Blob', 'AnytimeAllowanceRemaining', MsgUnknownValue);
      ReceiveSignalStrength := Data.ReadString('Data', 'CurrentSQF',                MsgUnknownValue);
    end;

    case Info.TurboPageState of
      '1':     Info.TurboPageState := MsgOn;
      '0':     Info.TurboPageState := MsgOff;
    end;

    case Info.Throttled of
      '2':     Info.Throttled := MsgYes;
      '1':     Info.Throttled := MsgNo;
    end;
  finally
    DataStream.Free;
    Data.Free;
  end;
end;

end.
