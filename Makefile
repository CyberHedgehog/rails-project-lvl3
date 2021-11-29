install:
	bundle

migrate:
	bin/rails db:migrate

lint:
	rubocop
	slim-lint app/views

test:
	bin/rails test

start:
	bin/rails start

console:
	bin/rails console

.PHONY: test