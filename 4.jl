using HorizonSideRobots
r = Robot("starts/task4.sit",animate = true)

#диагональный крест
function mark_kross2!(robot)
    for side in ((Nord, West), (Nord, Ost), (Sud, West), (Sud, Ost))
        num_s = 0
        while !isborder_2(robot,side)            #проверяет границу
            num_s += mark_and_numsteps!(robot,side) #закрашивает по диагонали 
        end
        putmarker!(robot)
        goback!(robot,side::Tuple,num_s) #возвращается по числу шагов
    end
end

function goback!(robot,sides::Tuple,num_s)
    for _ in range(0,num_s-1)
        for side in sides
            move!(robot,inverse_side(side))
        end
    end
    
end

function mark_and_numsteps!(robot,sides::Tuple)
    num_steps = 0
    putmarker!(robot)
    for side in sides
        move!(robot,side)
        num_steps += 1
    end
    return num_steps//2
end

function isborder_2(robot,sides::Tuple)
    side1, side2 = sides
    if (isborder(robot,side1) == 0) && (isborder(robot,side2) == 0)
        return false
    else
        return true
    end
end

inverse_side(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))

mark_kross2!(r)