function draw()
    imgui.Begin("Timing Point Spammer")

    state.IsWindowHovered = imgui.IsWindowHovered()

    local INITIAL = state.GetValue("initial") or 0
    local END = state.GetValue("end") or 0
    local STEP = state.GetValue("step") or 1
    local BPM = state.GetValue("bpm") or 200
    local DEVIATION = state.GetValue("deviation") or 0
    local OFFSET = state.GetValue("offset") or 0

    if imgui.Button("Set Current Time as Initial") then
        INITIAL = state.SongTime
    end
    if imgui.Button("Set Current Time as End") then
        END = state.SongTime
    end
    if imgui.Button("Set Current Tempo as BPM") then
        BPM = state.CurrentTimingPoint.Bpm
    end
    _, INITIAL = imgui.InputInt("Initial",  INITIAL)
    _, END = imgui.InputInt("End", END)
    _, BPM = imgui.InputInt("BPM", BPM)
    _, STEP = imgui.InputInt("Step", STEP)
    _, DEVIATION = imgui.InputInt("Deviation", DEVIATION)
    _, OFFSET = imgui.InputFloat("Offset", OFFSET, .25)

    local timingpoints = {}

    if imgui.Button("click me") then
        for i = INITIAL, END, STEP do
            local time = i + math.random(-DEVIATION, DEVIATION)
            if time >= INITIAL and time <= END then
                table.insert(timingpoints, utils.CreateTimingPoint(i + math.random(-DEVIATION,DEVIATION), BPM))
            end
        end
        actions.PlaceTimingPointBatch(timingpoints)

        if OFFSET != 0 then
            actions.ChangeTimingPointOffsetBatch(timingpoints, OFFSET)
        end
    end

    state.SetValue("initial", INITIAL)
    state.SetValue("end", END)
    state.SetValue("step", STEP)
    state.SetValue("bpm", BPM)
    state.SetValue("deviation", DEVIATION)
    state.SetValue("offset", OFFSET)

    imgui.End()
end
