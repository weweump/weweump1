using HorizonSideRobots
robot = Robot("starts/task9.sit", animate = true)

#робот в маркере, маркеры в шахмат. подярке
function task9!(robot)
    putmarker!(robot)
    nums = markchessrow!(robot, 0)
    #flag=1 в пред клетке был маркер, =0 не было
    k = chessside!(robot,Nord)
    move_n!(robot,Sud,k)
    k = chessside!(robot,Sud)
    move_n!(robot,Nord,k)
    while !isborder(robot,West)
        move!(robot,West)
    end
    move_n!(robot,Ost,nums)

    
end

function markchessrow!(robot)
    flag = false
    for side in (West, Ost)
        while !isborder(robot, side)
            move!(robot,side)
            flag && putmarker!(robot)
            flag = !flag
        end
    end

end

function markchessrow!(robot, numspets)
    flag = false
    if ismarker(robot)
        flag = true
    end
    for side in (West, Ost)
        while !isborder(robot, side)
            move!(robot,side)
            !flag && putmarker!(robot)
            flag = !flag
            if side == West
                numspets += 1
            end
        end
    end
    return numspets
end

function chessside!(robot, side)
    k = 0
    while !isborder(robot,side)
        flag = false
        if ismarker(robot)
            flag = true
        end
        move!(robot,side)
        if flag
            move!(robot,West)
            markchessrow!(robot)
        else
            markchessrow!(robot)
            flag = !flag
        end
        k+=1
    end
    return k
end

function move_n!(robot, side::HorizonSide, n::Int)
    for _ in 1:n
        move!(robot,side)
    end    
end

task9!(robot)