def seqn [a b] {
	seq $a $b | wrap n | str to-int n
}

def last-duration [] {
	echo $nu.env.CMD_DURATION
}

def lower-column [p] {
	str from $p | str downcase $p
}

def upper-column [p] {
	str from $p | str upcase $p
}

def cap-column [p] {
	str from $p | str capitalize $p
}

def v [] {
	version | pivot | rename key value
}

def config-show [] {
	config | pivot | rename key value
}

def config-section [p] {
	config | get $p | pivot | rename key value | str from value
}
# config-section line_editor
# config-section color_config


def cd.. [] {
	cd ..
}

def cd... [] {
	cd ../..
}

def cd- [] {
	cd -
}

def go-cd [p] {
	let dir = `{{$nu.env.GOPATH}}/src/{{$p}}`
	cd $dir
}

def lname [p] {
	str downcase name | where name =~ $p
}

def size2int-col [p] {
	format filesize $p B | str from $p | str find-replace -a ',' '' $p | str to-int $p
}

def size2int [] {
	size2int-col size
}

def insert-extension [] {
	insert ext { each {echo $it.name | path extension}}
	# FIXME: 'path extension' is replaced with 'path split' recently
}

def ssv [] {
	from ssv --noheaders --aligned-columns
}

def split-lines [] {
	split row '\n' | split column '\n'
}

def match-i [column regex] {
	match $column $(build-string "(?i)" $regex)
}

def is-py [] {
	match name .*\.py
}

def column-contains [column string] {
	where $(str from $column | str contains -i $string $column | get $column) == $true
}
# Example: ls | column-contains name abc

def name [string] {
	# where name =~ $string  # <-- case-sensitive
	column-contains name $string  # <-- case-insensitive
}

def value [string] {
	# where value =~ $string  # <-- case-sensitive
	column-contains value $string  # <-- case-insensitive
}

def hex2int [s] {
	echo $s | str to-int -r 16
}

def show-path-count [] {
	echo $nu.path | wrap path | sort-by path | uniq -c | sort-by count -r
}

def seq2 [a b] {
	seq $(echo $a | into int) $(echo $b | into int)
}
# example: seq2 "-10" "-5"

def seq3 [a b c] {
	seq $(echo $a | into int) $(echo $b | into int) $(echo $c | into int)
}
# example: seq3 "-20" 2 "-10"
# example: seq3 "-10" "-2" "-20"

