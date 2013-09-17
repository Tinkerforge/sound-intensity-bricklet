Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback for intensity greater than 2000
    Sub ReachedCB(ByVal sender As BrickletSoundIntensity, ByVal intensity As Integer)
        System.Console.Line("Intensity: " + intensity.ToString())
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim si As New BrickletSoundIntensity(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 1 second (1000ms)
        si.SetDebouncePeriod(1000)

        ' Register threshold reached callback to function ReachedCB
        AddHandler si.IntensityReached, AddressOf ReachedCB

        ' Configure threshold for "greater than 2000"
        si.SetIntensityCallbackThreshold(">"C, 2000, 0)

        System.Console.Line("Press key to exit")
        System.Console.ReadKey()
        ipcon.Disconnect()
    End Sub
End Module
