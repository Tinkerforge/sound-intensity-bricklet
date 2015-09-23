Imports System
Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback subroutine for intensity callback
    Sub IntensityCB(ByVal sender As BrickletSoundIntensity, ByVal intensity As Integer)
        Console.WriteLine("Intensity: " + intensity.ToString())
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim si As New BrickletSoundIntensity(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Register intensity callback to subroutine IntensityCB
        AddHandler si.Intensity, AddressOf IntensityCB

        ' Set period for intensity callback to 0.05s (50ms)
        ' Note: The intensity callback is only called every 0.05 seconds
        '       if the intensity has changed since the last call!
        si.SetIntensityCallbackPeriod(50)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
