local format_frame = function(frame, event)
    local fmt = '<frame %-10s  %25s:%-2d  %3s:%s:%-15s>'
    return fmt:format(
        event, frame.source, frame.currentline,
        frame.what, frame.namewhat, frame.name)
end

local format_step = function(step)
    local fmt = '<step %-10s  %25s:%-2d  %3s:%-15s  %s>'
    return fmt:format(
        step.event, step.file, step.line,
        step.scope, step.func, step.name)
end

local format_stack = function(stack)
    local fmt = '<stack %-10s  %25s:%-2d  %15s>'
    return fmt:format(
        stack.event, stack.file, stack.line, stack.func)
end

local print_frame = function(frame, event, ...)
    print(format_frame(frame, event), ...)
end

local print_step = function(step, ...)
    print(format_step(step), ...)
end

local print_stack = function(stack, ...)
    print(format_stack(stack), ...)
end

return {
    format_frame = format_frame,
    format_step = format_step,
    format_stack = format_stack,
    print_frame = print_frame,
    print_step = print_step,
    print_stack = print_stack,
}
