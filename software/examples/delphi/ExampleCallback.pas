program ExampleCallback;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  SysUtils, IPConnection, BrickletSoundIntensity;

type
  TExample = class
  private
    ipcon: TIPConnection;
    si: TBrickletSoundIntensity;
  public
    procedure IntensityCB(sender: TBrickletSoundIntensity; const intensity: word);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'XYZ'; { Change to your UID }

var
  e: TExample;

{ Callback procedure for intensity callback }
procedure TExample.IntensityCB(sender: TBrickletSoundIntensity; const intensity: word);
begin
  WriteLn(Format('Intensity: %d', [intensity]));
end;

procedure TExample.Execute;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create;

  { Create device object }
  si := TBrickletSoundIntensity.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Set period for intensity callback to 1s (1000ms)
    Note: The intensity callback is only called every second
          if the intensity has changed since the last call! }
  si.SetIntensityCallbackPeriod(1000);

  { Register intensity callback to procedure IntensityCB }
  si.OnIntensity := {$ifdef FPC}@{$endif}IntensityCB;

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
