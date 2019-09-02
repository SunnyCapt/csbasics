#! /bin/bash

cd ../lab0

pathOf(){
        find . -name $1
}

permissions="nidorina 570;vulpix 500;mienshao 604;ferrothorn 335;deerling 620;magmortar 004;shellos 440;kirlia 317;purrloin 604;pineco 537;mightyena 440;dragonair2 660;ludicolo7 524;prinplup8 404;slakoth0 000;slakoth0 u+r;toxicroak6 524;weepinbell8 355"

setPermission(){
        path=`pathOf $1`
        echo "chmod $2 $path"
        chmod $2 $path
}

tempSign=$IFS
IFS=";"

for value in $permissions
do
        IFS=$tempSign
        val=( $value )
        setPermission ${val[0]} ${val[1]}
        IFS=";"
done

IFS=$tempSign

