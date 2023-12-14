using HorizonSideRobots
robot = Robot("starts/task2.sit",animate = true)

#маркеры по периметру
function mark_kross!(robot::Robot)    #главная функция
    for side in (Nord,Sud,West,Ost)
        putmarkers!(robot,side)       #перемещает робота и ставит маркер
        goback!(robot,inverse(side))  #возвращает робота в исх. точку 
    end
    putmarker!(robot)      
end

function putmarkers!(robot::Robot,side::HorizonSide)
    while !isborder(robot,side)
        move!(robot,side)
        putmarker!(robot)
    end

end

function goback!(robot::Robot,side::HorizonSide)
    while ismarker(robot)
        move!(robot,side)
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))

mark_kross!(robot)