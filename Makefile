install:
	bundle install

autocorrect:
	rubocop -A .

lint:
	bundle exec rubocop

test:
	bundle exec rake test