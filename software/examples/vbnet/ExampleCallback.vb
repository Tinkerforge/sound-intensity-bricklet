Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback function for intensity callback
    Sub IntensityCB(ByVal sender As BrickletSoundIntensity, ByVal intensity As Integer)
        System.Console.WriteLine("Intensity: " + intensity.ToString())
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim si As New BrickletSoundIntensity(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Set period for intensity callback to 1s (1000ms)
        ' Note: The intensity callback is only called every second
        '       if the intensity has changed since the last call!
        si.SetIntensityCallbackPeriod(1000)

        ' Register intensity callback to function IntensityCB
        AddHandler si.Intensity, AddressOf IntensityCB

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
