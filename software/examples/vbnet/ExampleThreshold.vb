Imports System
Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change XYZ to the UID of your Sound Intensity Bricklet

    ' Callback subroutine for intensity reached callback
    Sub IntensityReachedCB(ByVal sender As BrickletSoundIntensity, _
                           ByVal intensity As Integer)
        Console.WriteLine("Intensity: " + intensity.ToString())
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim si As New BrickletSoundIntensity(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 1 second (1000ms)
        si.SetDebouncePeriod(1000)

        ' Register intensity reached callback to subroutine IntensityReachedCB
        AddHandler si.IntensityReached, AddressOf IntensityReachedCB

        ' Configure threshold for intensity "greater than 2000"
        si.SetIntensityCallbackThreshold(">"C, 2000, 0)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
