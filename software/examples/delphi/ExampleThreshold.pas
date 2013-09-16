program ExampleThreshold;

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
    procedure ReachedCB(sender: TBrickletSoundIntensity; const intensity: word);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'XYZ'; { Change to your UID }

var
  e: TExample;

{ Callback for intensity greater than 2000 }
procedure TExample.ReachedCB(sender: TBrickletSoundIntensity; const intensity: word);
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

  { Get threshold callbacks with a debounce time of 1 seconds (1000ms) }
  si.SetDebouncePeriod(1000);

  { Register threshold reached callback to procedure ReachedCB }
  si.OnIntensityReached := {$ifdef FPC}@{$endif}ReachedCB;

  { Configure threshold for "greater than 2000" }
  si.SetIntensityCallbackThreshold('>', 2000, 0);

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
