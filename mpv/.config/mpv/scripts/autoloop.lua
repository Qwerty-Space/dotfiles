-- mpv issue 5222
-- Automatically set loop-file=inf for duration <= given length. Default is 5s
-- Use autoloop_duration=n in script-opts/autoloop.conf to set your preferred length
-- Alternatively use script-opts=autoloop-autoloop_duration=n in mpv.conf (takes priority)


require 'mp.options'

function getOption()
    -- Use recommended way to get options
    local options = {autoloop_duration = 5}
    read_options(options)
    autoloop_duration = options.autoloop_duration
end

function set_loop()
    local duration = mp.get_property_native("duration")

    -- Checks whether the loop status was changed for the last file
    was_loop = mp.get_property_native("loop-file")

    -- Cancel operation if there is no file duration
    if not duration then
        return
    end

    -- Loops file if was_loop is false, and file meets requirements
    if not was_loop and duration <= autoloop_duration then
        mp.set_property_native("loop-file", true)
        -- Unloops file if was_loop is true, and file does not meet requirements
    elseif was_loop and duration > autoloop_duration then
        mp.set_property_native("loop-file", false)
    end
end


getOption()
mp.register_event("file-loaded", set_loop)
