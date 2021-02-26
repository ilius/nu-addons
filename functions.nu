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
}

def ssv [] {
	from ssv --noheaders --aligned-columns
}

def split-lines [] {
	split row '\n' | split column '\n'
}

def is-py [] {
	match name .*\.py
}
