install:
	bundle install

autocorrect:
	rubocop -A .

lint:
	rubocop .

test:
	rake test