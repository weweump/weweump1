using HorizonSideRobots
robot = Robot("starts/task19.sit",animate = true)

#рекурсивно до упора в заданном направлении
function move_recursion!(robot,side) 
    if (!isborder(robot,side))
        move!(robot,side)
        move_recursion!(robot,side)
    end
end