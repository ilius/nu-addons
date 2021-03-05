def find [] {
	# TODO: can pass any number of arguments to pass to find?
	/usr/bin/find . -type f | ssv | rename name
}

def find-ls [] {
	/usr/bin/find . -type f | ssv | rename name | each {ls $it.name}
}

def first-line [path] {
	/usr/bin/head -n1 $path | split-lines | get Column1
}

def insert-first-line [] {
	insert first_line {each {first-line $it.name}}
}

def search-first-line [s] {
	insert-first-line | where first_line =~ $s
}

def file [$p] {
	/usr/bin/file -b $p | split-lines | get Column1
}

def insert-file-type [] {
	insert file_type {each {file $it.name}}
}

def wc [] {
	to csv | /usr/bin/wc | split row "\n" | split column " " -c | rename lines words chars
}

def wcf [path] {
	/usr/bin/wc $path | split row "\n" | split column " " -c | rename lines words chars path
}

def nth-line [n path] {
	sed -n $(build-string $n "p") $path | split-lines | get Column1
}

def insert-nth-line [n] {
	insert $(build-string "line" $n) {each {nth-line $n $it.name}} | empty? $(build-string "line" $n) {echo ""}
}

def search-nth-line [n s] {
	insert-nth-line $n | where $(get $(build-string "line" $n)) =~ $s
}

def int2hex [n] {
	printf '%x' $(build-string $n)
}
