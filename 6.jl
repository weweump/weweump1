using HorizonSideRobots
r = Robot("starts/task6.sit", animate = true)

inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side)+2,4)) 
nextside(Side::HorizonSide) = HorizonSide(mod(Int(Side)+1,4)) 
prevside(Side::HorizonSide ) = HorizonSide(mod(Int(Side)-1,4)) 
function bottom_right() 
    moves = [] 
    while !isborder(r,Sud) || !isborder(r,Ost) 
        if isborder(r,Sud) 
            move!(r,Ost) 
            push!(moves,Ost) 
        else 
            move!(r,Sud) 
            push!(moves,Sud) 
        end 
    end 
    return reverse(moves) 
end 
function marking_outside_border(Side) 
    for i in 1:4 
        while !isborder(r,Side) 
            move!(r,Side) 
            putmarker!(r) 
        end 
        Side = nextside(Side) 
    end 
end 
function go_inverse(move) 
    for i in move 
        move!(r,inverse(i)) 
    end 
end 
function n6() 
    t = bottom_right() 
    marking_outside_border(Nord) 
    go_inverse(t) 
end 
n6()