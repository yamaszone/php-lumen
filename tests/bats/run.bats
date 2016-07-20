#!/usr/bin/env bats

load test_helper

@test "'run' script displays help." {
	run ./run
	assert_contains "$output" "Usage:"
}

@test "'run' script launches app." {
	run docker rm -f php-lumen
	run ./run app
	assert_contains "$output" $?

	run docker exec php-lumen php --version
	assert_contains "$output" "PHP 7.0"

	run docker exec php-lumen apachectl -V
	assert_contains "$output" "Apache/2.4"

	run docker exec php-lumen /bin/bash -c "lumen --version"
	assert_contains "$output" "Lumen Installer version 1.0"

	# Tearing down container spun up by test
	run docker rm -f php-lumen
}
