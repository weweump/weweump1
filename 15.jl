using HorizonSideRobots
robot = Robot("starts/task15.sit",animate = true)

function cross!(robot) #функция крест
    putmarker!(robot)
        for (side1,side2) in  ( (Nord,Ost),(Nord,West),(Sud,Ost),(Sud,West) )
        diagonal_along!(robot,side1,side2)
        end
end


function diagonal_along!(robot, side1, side2) #по диагонали и ставит маркеры
  x=0 #количество шагов до исходной
  while try_move_along!(robot,side1,side2) #идет и ставит маркеры
    x+=1
  end
  for i in 1:x #возвращается
    move_recursion!(robot,inverse(side1)) 
    move_recursion!(robot,inverse(side2))
  end
end


function try_move_along!(robot,side1,side2) #диагональный along. Сначала идет в сайд1 и сайд2, если нет - в предыдущую клетку 
        if (try_move!(robot,side2))         #после каждого удачного прохода по диагонали ставит маркер
            putmarker!(robot)
            return true
        else
            move!(robot,inverse(side1))
        end
    end
    if (try_move!(robot,side2))
        if (try_move!(robot,side1))
             putmarker!(robot)
                return true
        else
            move!(robot,inverse(side2))
            return false
        end
    else
        return false
    end
       
end

function try_move!(robot,side) #если перегородка не идет
     if (!isborder(robot,side))
        move!(robot,side)
        return true
     else
        return false
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side) +2)% 4)
right(side::HorizonSide) = HorizonSide((Int(side) +3)% 4)
left(side::HorizonSide) = HorizonSide((Int(side) +1)% 4)