function copy_path()
    local output = mp.get_property("path")
    if not os.getenv('windir') then
        local pipe = io.popen("xclip -silent -in -selection clipboard", "w")
        pipe:write(output)
        pipe:close()
    else
        mp.commandv("run", "powershell", "set-clipboard", output)
    end
    mp.osd_message("Path copied")
end

function copy_timestamp()
    local uri = mp.get_property("path")
    local pos = mp.get_property_number("time-pos")
    local fpos = tostring(math.floor(pos + 0.5))

    if string.find(uri, "youtu%.?be") then
        output = uri .. "?t=" .. fpos
    else
        output = "'"..uri.." @"..fpos
        output = string.format('"%s @%s seconds"', uri, fpos)
    end

    if not os.getenv('windir') then
        local pipe = io.popen("xclip -silent -in -selection clipboard", "w")
        pipe:write(output)
        pipe:close()
    else
        mp.commandv("run", "powershell", "set-clipboard", output)
    end
    mp.osd_message("Position copied")
end



mp.add_key_binding("ctrl+c", "copy-path", copy_path)
mp.add_key_binding("ctrl+C", "copy-timestamp", copy_timestamp)