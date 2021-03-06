#!/bin/sh

echo "Starting program at $(date) in $(pwd)"

echo "Running program $0 with $# arguments with pid $$"

# $@, its a iterator for $1 to $9 if any exist.
for file in "$@"; do
    grep "been searched" "$file" >/dev/null 2>/dev/null
    #we redirect STDOUT and STDERR to a null register since we donot care about them

    # shellcheck disable=SC2181
    if [ "$?" -ne 0 ]; then
        #if grep exit code not equal to 0
        echo "File $file dose not have any been searched, adding one"
        echo "# been searched" >>"$file"
    fi
done

# colorful
for R in $(seq 0 20 255); do
    printf "\e[38;2;%s;255;255m c \e[0m" "$R"
done

fuc() {
    echo "hello"
}
fuc
