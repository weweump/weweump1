using HorizonSideRobots
robot = Robot("starts/task8.sit",animate = true)

#в клетке с маркером
function find_marker!(robot)
    side = Nord
    n = 0                   #каждые 2 поворота
    flag = true                 #+n когда флаг true
    while !find_marker!(robot,side,n) #остановит робота в маркере по прошествии n шагов. вернет true если найдет, false если нет 
        if flag
            n = n + 1
        end
        flag  = !flag
        side = left(side)
    end
end

function  find_marker!(robot,side,max_num_steps)
    for _ in 1:max_num_steps
         if ismarker(robot)
            return true
         end            
        move!(robot,side)              
    end
    return false            
end

function move_n!(robot, side::HorizonSide, n)
    for _ in 1:n
        move!(robot,side)
    end    
end

left(side::HorizonSide) = HorizonSide(mod(Int(side)+1,4))

find_marker!(robot)


 


