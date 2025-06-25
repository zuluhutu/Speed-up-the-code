Measure-Command {
    $bigFileName = "$($PSScriptRoot)\plc_log.txt"
    $plcArray = @('PLC_A', 'PLC_B', 'PLC_C', 'PLC_D')
    $errorArray = @('Sandextrator overload', 'Conveyor misalignment', 'Valve stuck', 'Temperature warning')
    $statusArray = @('OK', 'WARN', 'ERR')
    $logCount = 50000
    $baseDate = Get-Date
    $random = [System.Random]::new()
    $writer = [System.IO.StreamWriter]::new($bigFileName)
    try
    {
        for ($i = 0; $i -lt $logCount; $i++)
        {
            $timestamp = $baseDate.AddSeconds(-$i).ToString("yyyy-MM-dd HH:mm:ss")
            $plc = $plcArray[$random.Next(4)]
            $operator = $random.Next(101, 121)
            $batch = $random.Next(1000, 1101)
            $status = $statusArray[$random.Next(3)]
            $machineTemp = [math]::Round($random.Next(60, 110) + $random.NextDouble(), 2)
            $load = $random.Next(0, 101)

            if ($random.Next(1, 8) -eq 4)
            {
                $errorType = $errorArray[$random.Next(4)]
                if ($errorType -eq 'Sandextractor overload')
                {
                    $value = $random.Next(1, 11)
                    $writer.WriteLine("ERROR; $timestamp; $plc; $errorType; $value; $status; $operator; $batch; $machineTemp; $load")
                }
                else
                {
                    $writer.WriteLine("ERROR; $timestamp; $plc; $errorType; ; $status; $operator; $batch; $machineTemp; $load")
                }
            }
            else
            {
                $writer.WriteLine("INFO; $timestamp; $plc; System running normally; ; $status; $operator; $batch; $machineTemp; $load")
            }
        }
    }
    finally
    {
        $writer.Close()
    }
}
