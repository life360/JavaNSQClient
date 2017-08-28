VERSION_BASE=1.1.0.RC1
VERSION_LIFE360=${VERSION_BASE}.LIFE360

build:
	mvn package

install: build
	mvn install:install-file -Dfile=target/nsq-client-${VERSION_BASE}.jar -DgroupId=com.github.brainlag -DartifactId=nsq-client -Dversion=${VERSION_LIFE360} -Dpackaging=jar

no-test:
	mvn -Dmaven.test.skip=true package

.PHONY: build install no-test
