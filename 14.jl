using HorizonSideRobots
robot = Robot("starts/task14.sit",animate = true)

function try_move!(robot, side) 
    check!(robot) #один шаг +1 если не ставится маркер, но еще +1 ставит маркеры
    if isborder(robot, side)
        return false
    else       
        move!(robot, side)
        check!(robot)
        return true
    end
end

function wall_recursion!(robot,side) #рекурсивный способ обхода стены 
    if (isborder(robot,side))
        if (try_move!(robot,right(side)) )
                wall_recursion!(robot,side)
                move!(robot,inverse(right(side)))
        else
            return false
        end
    else
        move!(robot,side)
    end
end



function  go_to_corner!(robot) #идем в угол когда завершаем змейку
    while (!isborder(robot,Sud))
        move!(robot,Sud)
     end
     while (!isborder(robot,West))
        move!(robot,West)
     end
end


function along_try!(robot, side) #идем прямо, если перегородку, рекурсивно обходим
    for _i in 1:11 
        check!(robot)
        wall_recursion!(robot,side)            
        check!(robot)
    end
end

function snake!( robot, (move_side, next_row_side)::NTuple{2,HorizonSide} = (Nord, Ost)) 
    along_try!(robot, move_side) #идем до стены
    while try_move!(robot, next_row_side) #пока можем можем идти вверх идем змейкой. если не можем змейка останавливается в угол
        move_side = inverse(move_side)
        along_try!(robot, move_side)
    end
end

function find_corner!(robot) #поиск угла
    num_steps_West=0
    num_steps_Sud=0
 while (!isborder(robot,Sud))
    move!(robot,Sud)
    num_steps_Sud+=1
 end
 while (!isborder(robot,West))
    move!(robot,West)
    num_steps_West+=1
 end
    return num_steps_Sud,num_steps_West
end

function go_to_home!(robot,num_steps_Sud,num_steps_West) #возвращается обратно по шагам функции выше
    for _i in 1:num_steps_Sud
        move!(robot,Nord)
    end
    for _i in 1:num_steps_West
        move!(robot,Ost)
    end
end

function check!(robot) #проверка координат
    x,y=get_coord(robot) #присваеваем х и у координаты робота
    if ( ( ( abs(x+y) )%2 )==0 )
        putmarker!(robot)
    end
end


function solve!(robot,(side1, side2)::NTuple{2,HorizonSide} = (Ost, Nord)) #один вектор по два контейнера(2 стороны в одной ячейке)
   num_steps_Sud,num_steps_West=find_corner!(robot) #шаги до угла
   snake!(robot,(side1,side2))
   go_to_corner!(robot)
   go_to_home!(robot,num_steps_Sud,num_steps_West) #возврат по шагам
end

inverse(side::HorizonSide) = HorizonSide((Int(side) +2)% 4)
right(side::HorizonSide) = HorizonSide((Int(side) +3)% 4)