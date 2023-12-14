using HorizonSideRobots
robot = Robot("starts/task1.sit",animate = true)

#все клетки маркер
function mark_square!(robot)
    
    num_nord = topleft_num!(robot,Nord)
    num_west = topleft_num!(robot,West)  #левая верхняя
    for side in (Ost,Sud,West,Nord)
        markrow!(robot,side)    
    end                                   #закр периметр
    topleft_num!(robot,Nord)
    topleft_num!(robot,West)        #левая верхняя
    goback!(robot,Ost,num_west)
    goback!(robot,Sud,num_nord)     #исходная
    
end

function topleft_num!(robot,side)
    num = 0
    while !isborder(robot,side)
        move!(robot,side)
        num += 1
    end
    return num
end

function markrow!(robot,side)
    while !isborder(robot,side)
        putmarker!(robot)
        move!(robot,side)
    end
end

function goback!(robot,side,num_steps)
    for _ in range(0,num_steps-1) 
        move!(robot,side)  
    end 
end

mark_square!(robot)