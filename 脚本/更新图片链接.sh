#!/bin/bash
read_dir(){
    for file in `ls -a $1`
    do
        if [ -d $1"/"$file ]
        then
            if [[ $file != '.git' && $file != '小说' && $file != '.' && $file != '..' ]]
            then
                read_dir $1"/"$file
            fi
        else
            filename=$1"/"$file
			echo $filename
			sed 's/https:\/\/gitee.com\/ababa-317\/image\/raw\/master\/images\//https:\/\/wwt13-images-1305051431.cos.ap-beijing.myqcloud.com\/img\//g' -i $filename
        fi
    done
}
#测试目录 test
read_dir ../../Notes
