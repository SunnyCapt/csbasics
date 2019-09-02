#!/usr/bin/env bash

cd ..

mkdir lab0; cd lab0
mkdir ludicolo7 toxicroak6 weepinbell8
touch dragonair2 slakoth0 prinplup8

cd weepinbell8
mkdir pineco
touch purrloin mightyena

cd ../toxicroak6
mkdir kirlia
touch deerling magmortar shellos

cd ../ludicolo7
mkdir nidorina vulpix ferrothorn
touch mienshao

cd ..

pathOf(){
        find . -name $1
}
writeToFile(){
        echo -e $1 > `pathOf $2`
}

writeToFile "Развитые способности Marvel Scale" "dragonair2"
writeToFile "Возможности Overland=5 Surface=8 Underwater=5\nJump=2 Power=2 Intelligence=3 Fountain=0" "prinplup8"
writeToFile "Развитые\nспособности Forewarn" "slakoth0"
writeToFile "Тип диеты\nHerbivore" "deerling"
writeToFile "Способности Ember Smokescreen Faint Attack Fire\nSpin Clear Smog Flame\nBurst Confuse Ray Fire Punch Lava Plume Sunny\nDay Flamethrower\nFire Blast Hyper Beam" "magmortar"
writeToFile "Тип покемона WATER\nNONE" "shellos"
writeToFile "Живет Forest Grassland Rainforest\nUrban" "purrloin"
writeToFile "Ходы Body Slam Counter Covet Crunch Dark Pulse\nDouble-Edge Foul Play\nHyper Voice Iron Tail Mud-Slap Psych Up Sleep\nTalk Snatch Snore Spite Sucker Punch Super Fang Uproar" "mightyena"

