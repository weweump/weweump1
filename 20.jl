using HorizonSideRobots
robot = Robot("starts/task20.sit",animate = true)

#рекурсивно до стены, ставит маркер и обратно
function moving_recursion!(robot,side)  
    if (isborder(robot, side))
        putmarker!(robot)
    else
        move!(robot, side)
        moving_recursion!(robot, side)
        move!(robot, inverse(side))
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side) +2)% 4)