using HorizonSideRobots
robot = Robot("starts/task9_.sit", animate = true)

#с лев.нижн. маркеры в шахмат. NxN
                #flag=1 маркер, =0 - нет 
function task10(robot,n)
        n1,n2 = goangle_andcount!(robot,Sud,West)
        side = Ost
        flag = true
        while !isborder(robot,Nord)
           for _ in range(1,n)
            !flag && move_n!(robot,side,n)
            markchessrow_n!(robot,n,side)
            move_andcount!(robot,inverse(side))
            if !isborder(robot,Nord)
                move!(robot,Nord)
            end
           end
           flag = !flag
        end
        goangle_andcount!(robot,Sud,West)
        goback!(robot,n1,n2,Nord,Ost)
end

function markchessrow_n!(robot, n,side)
    flag = false
        while !isborder(robot, side)
            for _ in range(1,n)
                !flag && putmarker!(robot)
                if !isborder(robot,side)
                    move!(robot,side)
                end
            end
            flag = !flag
        end
end

function goangle_andcount!(robot::Robot,side1::HorizonSide,side2::HorizonSide)
    num_s1 = num_s2 = 0
    while !isborder(robot, side1) || !isborder(robot,side2)
        num_s1 += move_andcount!(robot,side1)
        num_s2 += move_andcount!(robot,side2)
    end
    return (num_s1, num_s2)
end

function goback!(robot::Robot, n_1::Int, n_2::Int,side1,side2)
    for _ in range(0,n_1-1)
        move!(robot, side1)
    end
    for _ in range(0,n_2-1)
        move!(robot,side2)
    end
end

function move_n!(robot, side::HorizonSide, n::Int)
    for _ in 1:n
        move!(robot,side)
    end    
end

function move_andcount!(robot::Robot, side::HorizonSide)
    num_s  = 0
    while !isborder(robot,side)
        move!(robot,side)
        num_s += 1
    end
    return num_s
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))

task10(robot,)