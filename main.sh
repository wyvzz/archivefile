#!/bin/bash

archive_file() {
    local file=$1
    local dir=$2
    local filename=$(basename "$file")
    tar -cf "$dir/$filename.tar" -C "$dir" "$filename"
    echo "Файл $filename архивирован в $filename.tar"
}

if [ $# -ne 2 ]; then
    echo "Использование: $0 <папка> <максимальный размер файла (в байтах)>"
    exit 1
fi

directory=$1
max_size=$2

if [ ! -d "$directory" ]; then
    echo "Директория $directory не найдена."
    exit 1
fi

for file in "$directory"/*; do
    if [ -f "$file" ]; then
        file_size=$(stat -c%s "$file")
        if [ "$file_size" -gt "$max_size" ]; then
            archive_file "$file" "$directory"
        fi
    fi
done
