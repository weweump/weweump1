using HorizonSideRobots
robot = Robot("starts/task1.sit",animate = true)

#прямой крест
function all_mark!(robot::Robot)
    num_nord = topleft_num!(robot,Nord)
    num_west = topleft_num!(robot,West)   
    side = Ost
    markrow!(robot,side)
    while !isborder(robot,Sud)
        move!(robot,Sud)
        side = inverse(side)
        markrow!(robot,side)
    end
    topleft_num!(robot,Nord)
    topleft_num!(robot,West)
    goback!(robot,Sud,num_nord)
    goback!(robot,Ost,num_west)
end

function goback!(robot,side,num_steps)
    for x in range(0,num_steps-1)
        move!(robot,side)
    end
end

function topleft_num!(robot::Robot,side::HorizonSide)
    num = 0
    while !isborder(robot, side)
        move!(robot,side)
        num += 1
    end
    return num
end

function markrow!(robot::Robot,side::HorizonSide)
    while !isborder(robot,side)
        putmarker!(robot)
        move!(robot,side)
    end
    putmarker!(robot)
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))

all_mark!(robot)