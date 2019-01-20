
function gAC.LogEvent( string )
    local eventLogFile = "g-AC-Logs/eventlogs.txt"
    if !file.IsDir( "g-AC-Logs", "DATA" ) then
        file.CreateDir( "g-AC-Logs", "DATA" )

        file.Write( eventLogFile, "[" .. os.date( "%m/%d/%Y: %H:%M:%S", os.time() ) .. "] " .. string .. "\n" )
    else
        file.Append( eventLogFile, "[" .. os.date( "%m/%d/%Y: %H:%M:%S", os.time() ) .. "] " .. string .. "\n" )
    end
end